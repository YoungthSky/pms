#!/bin/bash
# ============================================
# PMS 数据还原脚本
# 功能：从备份文件还原 MySQL 数据库 / Redis / 上传文件
# 用法：
#   ./restore.sh db <备份文件路径>       # 还原数据库
#   ./restore.sh files <备份文件路径>    # 还原上传文件
#   ./restore.sh redis <备份文件路径>    # 还原Redis
#   ./restore.sh list                   # 列出可用备份
# ============================================

set -e

# 加载环境变量
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

if [ -f "$PROJECT_DIR/.env.docker" ]; then
    export $(grep -v '^#' "$PROJECT_DIR/.env.docker" | xargs)
fi

# 配置变量
BACKUP_DIR="${BACKUP_DIR:-$PROJECT_DIR/data/backup}"
MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD:-pms_root_2026}"
MYSQL_DATABASE="${MYSQL_DATABASE:-pms}"
REDIS_PASSWORD="${REDIS_PASSWORD:-pms_redis_2026}"

RESTORE_TYPE="${1:-}"
BACKUP_FILE="${2:-}"

# ---------- 列出可用备份 ----------
list_backups() {
    echo "============================================"
    echo "可用的数据库备份:"
    echo "============================================"
    ls -lht "$BACKUP_DIR/db/" 2>/dev/null | head -20 || echo "  (无)"
    echo ""
    echo "============================================"
    echo "可用的文件备份:"
    echo "============================================"
    ls -lht "$BACKUP_DIR/files/" 2>/dev/null | head -20 || echo "  (无)"
    echo ""
    echo "============================================"
    echo "可用的Redis备份:"
    echo "============================================"
    ls -lht "$BACKUP_DIR/redis/" 2>/dev/null | head -20 || echo "  (无)"
}

# ---------- 还原数据库 ----------
restore_database() {
    local file="$1"
    
    if [ ! -f "$file" ]; then
        echo "错误: 备份文件不存在: $file"
        exit 1
    fi
    
    echo "============================================"
    echo "警告: 即将还原数据库，当前数据将被覆盖！"
    echo "备份文件: $file"
    echo "目标数据库: $MYSQL_DATABASE"
    echo "============================================"
    read -p "确认还原？(输入 yes 继续): " confirm
    
    if [ "$confirm" != "yes" ]; then
        echo "已取消还原操作"
        exit 0
    fi
    
    echo "[1/2] 停止后端服务..."
    docker stop pms-backend 2>/dev/null || true
    
    echo "[2/2] 还原数据库..."
    
    # 根据文件类型选择解压方式
    if [[ "$file" == *.gz ]]; then
        gunzip -c "$file" | docker exec -i pms-mysql mysql \
            -uroot \
            -p"$MYSQL_ROOT_PASSWORD" \
            "$MYSQL_DATABASE"
    else
        docker exec -i pms-mysql mysql \
            -uroot \
            -p"$MYSQL_ROOT_PASSWORD" \
            "$MYSQL_DATABASE" < "$file"
    fi
    
    echo "启动后端服务..."
    docker start pms-backend
    
    echo ""
    echo "数据库还原完成！"
}

# ---------- 还原上传文件 ----------
restore_files() {
    local file="$1"
    
    if [ ! -f "$file" ]; then
        echo "错误: 备份文件不存在: $file"
        exit 1
    fi
    
    echo "============================================"
    echo "警告: 即将还原上传文件，当前文件将被覆盖！"
    echo "备份文件: $file"
    echo "============================================"
    read -p "确认还原？(输入 yes 继续): " confirm
    
    if [ "$confirm" != "yes" ]; then
        echo "已取消还原操作"
        exit 0
    fi
    
    echo "还原上传文件..."
    
    # 备份当前文件（以防万一）
    UPLOAD_DIR="$PROJECT_DIR/data/upload"
    if [ -d "$UPLOAD_DIR" ] && [ "$(ls -A $UPLOAD_DIR 2>/dev/null)" ]; then
        TIMESTAMP=$(date +%Y%m%d_%H%M%S)
        tar -czf "$BACKUP_DIR/files/upload_before_restore_${TIMESTAMP}.tar.gz" -C "$PROJECT_DIR/data" upload/
        echo "  -> 已备份当前文件: upload_before_restore_${TIMESTAMP}.tar.gz"
    fi
    
    # 解压还原
    tar -xzf "$file" -C "$PROJECT_DIR/data/"
    
    echo ""
    echo "上传文件还原完成！"
}

# ---------- 还原 Redis ----------
restore_redis() {
    local file="$1"
    
    if [ ! -f "$file" ]; then
        echo "错误: 备份文件不存在: $file"
        exit 1
    fi
    
    echo "============================================"
    echo "警告: 即将还原Redis数据！"
    echo "备份文件: $file"
    echo "============================================"
    read -p "确认还原？(输入 yes 继续): " confirm
    
    if [ "$confirm" != "yes" ]; then
        echo "已取消还原操作"
        exit 0
    fi
    
    echo "[1/3] 停止 Redis..."
    docker stop pms-redis
    
    echo "[2/3] 替换数据文件..."
    if [[ "$file" == *.rdb ]]; then
        cp "$file" "$PROJECT_DIR/data/redis/dump.rdb"
    fi
    
    echo "[3/3] 启动 Redis..."
    docker start pms-redis
    
    echo ""
    echo "Redis 还原完成！"
}

# ---------- 主逻辑 ----------
case "$RESTORE_TYPE" in
    db)
        if [ -z "$BACKUP_FILE" ]; then
            echo "用法: $0 db <备份文件路径>"
            echo "示例: $0 db $BACKUP_DIR/db/pms_full_20260731_020000.sql.gz"
            exit 1
        fi
        restore_database "$BACKUP_FILE"
        ;;
    files)
        if [ -z "$BACKUP_FILE" ]; then
            echo "用法: $0 files <备份文件路径>"
            echo "示例: $0 files $BACKUP_DIR/files/upload_20260731_020000.tar.gz"
            exit 1
        fi
        restore_files "$BACKUP_FILE"
        ;;
    redis)
        if [ -z "$BACKUP_FILE" ]; then
            echo "用法: $0 redis <备份文件路径>"
            echo "示例: $0 redis $BACKUP_DIR/redis/dump_20260731_020000.rdb"
            exit 1
        fi
        restore_redis "$BACKUP_FILE"
        ;;
    list)
        list_backups
        ;;
    *)
        echo "PMS 数据还原工具"
        echo ""
        echo "用法: $0 <类型> [备份文件路径]"
        echo ""
        echo "类型:"
        echo "  db <file>     还原MySQL数据库"
        echo "  files <file>  还原上传文件"
        echo "  redis <file>  还原Redis数据"
        echo "  list          列出所有可用备份"
        echo ""
        echo "示例:"
        echo "  $0 list"
        echo "  $0 db ./data/backup/db/pms_full_20260731_020000.sql.gz"
        echo "  $0 files ./data/backup/files/upload_20260731_020000.tar.gz"
        exit 1
        ;;
esac
