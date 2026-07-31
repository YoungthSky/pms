#!/bin/bash
# ============================================
# PMS 内网服务器一键部署脚本
# 功能：在离线服务器上完成首次部署
# 用法：./deploy.sh
# 前提：Docker 和 Docker Compose 已安装
# ============================================

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

echo "============================================"
echo "PMS 内网部署工具"
echo "四川省甘孜监狱执法证据保全系统"
echo "============================================"
echo ""

# ---------- 环境检查 ----------
info "[检查] 验证 Docker 环境..."

if ! command -v docker &> /dev/null; then
    error "Docker 未安装！请先安装 Docker。
    
离线安装 Docker 步骤:
1. 在有网机器下载 Docker 离线包:
   https://download.docker.com/linux/static/stable/x86_64/
   下载: docker-24.0.7.tgz (或更新版本)

2. 复制到内网服务器后执行:
   tar -xzf docker-24.0.7.tgz
   cp docker/* /usr/bin/
   
3. 创建 systemd 服务:
   cat > /etc/systemd/system/docker.service << 'EOF'
   [Unit]
   Description=Docker Application Container Engine
   After=network-online.target
   
   [Service]
   ExecStart=/usr/bin/dockerd
   ExecReload=/bin/kill -s HUP \$MAINPID
   Restart=on-failure
   
   [Install]
   WantedBy=multi-user.target
   EOF
   
4. 启动:
   systemctl daemon-reload
   systemctl start docker
   systemctl enable docker"
fi

if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    error "Docker Compose 未安装！
    
离线安装步骤:
1. 在有网机器下载:
   https://github.com/docker/compose/releases
   下载: docker-compose-linux-x86_64

2. 复制到内网服务器:
   cp docker-compose-linux-x86_64 /usr/local/bin/docker-compose
   chmod +x /usr/local/bin/docker-compose"
fi

info "Docker 环境正常"

# ---------- 加载镜像 ----------
info "[Step 1/4] 加载 Docker 镜像..."

IMAGE_FILE=$(find "$PROJECT_DIR" -name "pms-images-*.tar" | head -1)
if [ -z "$IMAGE_FILE" ]; then
    error "未找到镜像文件 pms-images-*.tar"
fi

info "加载镜像: $(basename $IMAGE_FILE)（可能需要几分钟）..."
docker load -i "$IMAGE_FILE"
info "镜像加载完成"

# ---------- 创建数据目录 ----------
info "[Step 2/4] 创建数据目录..."
mkdir -p "$PROJECT_DIR/data/mysql"
mkdir -p "$PROJECT_DIR/data/redis"
mkdir -p "$PROJECT_DIR/data/upload"
mkdir -p "$PROJECT_DIR/data/logs"
mkdir -p "$PROJECT_DIR/data/backup/db"
mkdir -p "$PROJECT_DIR/data/backup/files"
mkdir -p "$PROJECT_DIR/data/backup/redis"
info "数据目录创建完成"

# ---------- 安全提醒 ----------
info "[Step 3/4] 配置检查..."
echo ""
warn "============================================"
warn "重要：请确认已修改 .env.docker 中的默认密码！"
warn "============================================"
echo ""
echo "需要修改的配置项:"
echo "  MYSQL_ROOT_PASSWORD  - MySQL root密码"
echo "  MYSQL_PASSWORD       - MySQL 应用密码"
echo "  REDIS_PASSWORD       - Redis 密码"
echo "  DRUID_PASSWORD       - Druid 监控密码"
echo ""
read -p "是否已修改密码配置？(输入 yes 继续部署): " confirm
if [ "$confirm" != "yes" ]; then
    warn "请先编辑 .env.docker 文件修改密码，然后重新运行此脚本"
    echo "  vi $PROJECT_DIR/.env.docker"
    exit 0
fi

# ---------- 启动服务 ----------
info "[Step 4/4] 启动服务..."
cd "$PROJECT_DIR"

# 判断使用 docker-compose 还是 docker compose
if command -v docker-compose &> /dev/null; then
    COMPOSE_CMD="docker-compose"
else
    COMPOSE_CMD="docker compose"
fi

$COMPOSE_CMD --env-file .env.docker up -d

# ---------- 等待启动 ----------
info "等待服务启动..."
sleep 20

echo ""
echo "============================================"
echo "服务状态:"
echo "============================================"
$COMPOSE_CMD --env-file .env.docker ps

# ---------- 健康检查 ----------
echo ""
info "执行健康检查..."

# 检查 MySQL
if docker exec pms-mysql mysqladmin ping -h localhost --silent 2>/dev/null; then
    info "MySQL: 正常"
else
    warn "MySQL: 可能仍在初始化，请稍后检查"
fi

# 检查 Redis
if docker exec pms-redis redis-cli ping 2>/dev/null | grep -q "PONG"; then
    info "Redis: 正常"
else
    warn "Redis: 异常，请检查日志"
fi

# 检查后端
sleep 10
if curl -s -o /dev/null http://localhost:${BACKEND_PORT:-8080}/ 2>/dev/null; then
    info "后端: 正常"
else
    warn "后端: 可能仍在启动中，请稍等30秒后访问"
fi

echo ""
echo "============================================"
echo -e "${GREEN}部署完成！${NC}"
echo "============================================"
echo ""
echo "访问地址: http://$(hostname -I | awk '{print $1}'):${FRONTEND_PORT:-80}"
echo "默认账号: admin"
echo "默认密码: admin123"
echo ""
echo "============================================"
echo "日常运维命令:"
echo "============================================"
echo ""
echo "# 查看服务状态"
echo "$COMPOSE_CMD --env-file .env.docker ps"
echo ""
echo "# 查看后端日志"
echo "docker logs -f --tail 200 pms-backend"
echo ""
echo "# 重启所有服务"
echo "$COMPOSE_CMD --env-file .env.docker restart"
echo ""
echo "# 停止所有服务"
echo "$COMPOSE_CMD --env-file .env.docker down"
echo ""
echo "# 数据备份（建议设置定时任务）"
echo "bash scripts/backup.sh full"
echo ""
echo "# 设置每日自动备份（凌晨2点）"
echo "crontab -e"
echo "0 2 * * * $PROJECT_DIR/scripts/backup.sh full >> $PROJECT_DIR/data/logs/backup.log 2>&1"
echo ""
echo "============================================"
