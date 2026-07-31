#!/bin/bash
# ============================================
# PMS 版本升级脚本
# 功能：安全升级 PMS 系统（保留数据）
# 用法：./upgrade.sh <新版本号>
# 示例：./upgrade.sh v2.0.0
# ============================================
# 升级流程：
#   1. 自动备份当前数据
#   2. 停止所有服务
#   3. 替换后端 JAR 和前端 dist
#   4. 重新构建镜像
#   5. 执行数据库迁移脚本（如有）
#   6. 启动新版本服务
#   7. 健康检查
# ============================================

set -e

# 加载环境变量
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

if [ -f "$PROJECT_DIR/.env.docker" ]; then
    export $(grep -v '^#' "$PROJECT_DIR/.env.docker" | xargs)
fi

# 配置
NEW_VERSION="${1:-}"
BACKUP_DIR="${BACKUP_DIR:-$PROJECT_DIR/data/backup}"
MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD:-pms_root_2026}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# ---------- 参数检查 ----------
if [ -z "$NEW_VERSION" ]; then
    echo "PMS 版本升级工具"
    echo ""
    echo "用法: $0 <新版本号>"
    echo "示例: $0 v2.0.0"
    echo ""
    echo "升级前准备:"
    echo "  1. 将新版 pms-admin.jar 放入 docker/backend/ 目录"
    echo "  2. 将新版前端 dist/ 放入 docker/nginx/ 目录"
    echo "  3. 如有数据库迁移SQL，放入 docker/mysql/migration/ 目录"
    echo "     命名格式: V2.0.0__描述.sql"
    echo ""
    echo "当前版本: ${PMS_VERSION:-v1.0.0}"
    exit 1
fi

echo "============================================"
echo "PMS 版本升级"
echo "当前版本: ${PMS_VERSION:-v1.0.0}"
echo "目标版本: $NEW_VERSION"
echo "时间: $(date '+%Y-%m-%d %H:%M:%S')"
echo "============================================"
echo ""

# ---------- 升级前检查 ----------
info "检查升级文件..."

if [ ! -f "$PROJECT_DIR/docker/backend/pms-admin.jar" ]; then
    error "未找到新版 JAR 包: docker/backend/pms-admin.jar"
fi

if [ ! -d "$PROJECT_DIR/docker/nginx/dist" ]; then
    error "未找到新版前端文件: docker/nginx/dist/"
fi

info "升级文件检查通过"

# ---------- 确认升级 ----------
echo ""
warn "即将执行版本升级，请确认："
echo "  - 当前版本: ${PMS_VERSION:-v1.0.0}"
echo "  - 目标版本: $NEW_VERSION"
echo "  - 升级前会自动备份数据"
echo ""
read -p "确认升级？(输入 yes 继续): " confirm
if [ "$confirm" != "yes" ]; then
    info "已取消升级"
    exit 0
fi

# ---------- Step 1: 备份 ----------
info "[Step 1/6] 备份当前数据..."
bash "$SCRIPT_DIR/backup.sh" full
info "备份完成"

# ---------- Step 2: 停止服务 ----------
info "[Step 2/6] 停止所有服务..."
cd "$PROJECT_DIR"
docker-compose --env-file .env.docker down
info "服务已停止"

# ---------- Step 3: 更新版本号 ----------
info "[Step 3/6] 更新版本配置..."
sed -i "s/PMS_VERSION=.*/PMS_VERSION=$NEW_VERSION/" "$PROJECT_DIR/.env.docker"
info "版本号已更新为: $NEW_VERSION"

# ---------- Step 4: 重新构建镜像 ----------
info "[Step 4/6] 构建新版本镜像..."
docker-compose --env-file .env.docker build --no-cache backend frontend
info "镜像构建完成"

# ---------- Step 5: 数据库迁移 ----------
info "[Step 5/6] 检查数据库迁移脚本..."
MIGRATION_DIR="$PROJECT_DIR/docker/mysql/migration"

if [ -d "$MIGRATION_DIR" ]; then
    # 查找当前版本对应的迁移脚本
    MIGRATION_FILES=$(find "$MIGRATION_DIR" -name "${NEW_VERSION}__*.sql" -o -name "${NEW_VERSION}__*.sql" | sort)
    
    if [ -n "$MIGATION_FILES" ]; then
        info "发现数据库迁移脚本，启动 MySQL 执行迁移..."
        docker-compose --env-file .env.docker up -d mysql
        
        # 等待 MySQL 就绪
        info "等待 MySQL 启动..."
        for i in $(seq 1 30); do
            if docker exec pms-mysql mysqladmin ping -h localhost -uroot -p"$MYSQL_ROOT_PASSWORD" --silent 2>/dev/null; then
                break
            fi
            sleep 2
        done
        
        # 执行迁移脚本
        for sql_file in $MIGRATION_FILES; do
            info "执行迁移: $(basename $sql_file)"
            docker exec -i pms-mysql mysql \
                -uroot \
                -p"$MYSQL_ROOT_PASSWORD" \
                pms < "$sql_file"
        done
        
        info "数据库迁移完成"
    else
        info "无数据库迁移脚本"
    fi
else
    info "无迁移脚本目录，跳过"
fi

# ---------- Step 6: 启动新版本 ----------
info "[Step 6/6] 启动新版本服务..."
docker-compose --env-file .env.docker up -d

# ---------- 健康检查 ----------
info "等待服务启动..."
sleep 15

echo ""
echo "============================================"
echo "服务状态:"
echo "============================================"
docker-compose --env-file .env.docker ps

echo ""
info "检查后端健康状态..."
for i in $(seq 1 10); do
    if curl -s -o /dev/null -w "%{http_code}" http://localhost:${BACKEND_PORT:-8080}/ 2>/dev/null | grep -q "200\|401\|302"; then
        info "后端服务正常"
        break
    fi
    if [ $i -eq 10 ]; then
        warn "后端服务可能未完全启动，请手动检查: docker logs pms-backend"
    fi
    sleep 5
done

echo ""
echo "============================================"
echo -e "${GREEN}升级完成！${NC}"
echo "版本: $NEW_VERSION"
echo "访问地址: http://服务器IP:${FRONTEND_PORT:-80}"
echo "============================================"
echo ""
echo "如需回滚，请执行:"
echo "  1. docker-compose --env-file .env.docker down"
echo "  2. 修改 .env.docker 中 PMS_VERSION 为旧版本"
echo "  3. 还原数据库: ./restore.sh db <备份文件>"
echo "  4. docker-compose --env-file .env.docker up -d"
