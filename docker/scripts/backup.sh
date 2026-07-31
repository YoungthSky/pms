#!/bin/bash
# ============================================
# PMS 数据备份脚本
# 功能：备份 MySQL 数据库 + Redis 数据 + 上传文件
# 用法：./backup.sh [备份类型: full|db|files]
# 定时任务示例（每天凌晨2点）：
#   crontab -e
#   0 2 * * * /opt/pms/docker/scripts/backup.sh full >> /opt/pms/data/logs/backup.log 2>&1
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
BACKUP_RETAIN_DAYS="${BACKUP_RETAIN_DAYS:-30}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_TYPE="${1:-full}"

# 创建备份目录
mkdir -p "$BACKUP_DIR/db"
mkdir -p "$BACKUP_DIR/files"
mkdir -p "$BACKUP_DIR/redis"

echo "============================================"
echo "PMS 备份开始"
echo "时间: $(date '+%Y-%m-%d %H:%M:%S')"
echo "类型: $BACKUP_TYPE"
echo "目录: $BACKUP_DIR"
echo "============================================"

# ---------- 数据库备份 ----------
backup_database() {
    echo "[1/3] 备份 MySQL 数据库..."
    
    # 全库备份（含结构和数据）
    docker exec pms-mysql mysqldump \
        -uroot \
        -p"$MYSQL_ROOT_PASSWORD" \
        --databases "$MYSQL_DATABASE" \
        --single-transaction \
        --routines \
        --triggers \
        --events \
        --set-gtid-purged=OFF \
        > "$BACKUP_DIR/db/pms_full_${TIMESTAMP}.sql"
    
    # 压缩备份文件
    gzip "$BACKUP_DIR/db/pms_full_${TIMESTAMP}.sql"
    
    echo "  -> 数据库备份完成: pms_full_${TIMESTAMP}.sql.gz"
    echo "  -> 文件大小: $(du -h "$BACKUP_DIR/db/pms_full_${TIMESTAMP}.sql.gz" | cut -f1)"
}

# ---------- Redis 备份 ----------
backup_redis() {
    echo "[2/3] 备份 Redis 数据..."
    
    # 触发 RDB 快照
    docker exec pms-redis redis-cli -a "$REDIS_PASSWORD" BGSAVE
    sleep 3
    
    # 复制 RDB 文件
    cp "$PROJECT_DIR/data/redis/dump.rdb" "$BACKUP_DIR/redis/dump_${TIMESTAMP}.rdb" 2>/dev/null || true
    cp "$PROJECT_DIR/data/redis/appendonly.aof" "$BACKUP_DIR/redis/appendonly_${TIMESTAMP}.aof" 2>/dev/null || \
    cp -r "$PROJECT_DIR/data/redis/appendonlydir" "$BACKUP_DIR/redis/appendonlydir_${TIMESTAMP}" 2>/dev/null || true
    
    echo "  -> Redis 备份完成"
}

# ---------- 上传文件备份 ----------
backup_files() {
    echo "[3/3] 备份上传文件..."
    
    UPLOAD_DIR="$PROJECT_DIR/data/upload"
    if [ -d "$UPLOAD_DIR" ] && [ "$(ls -A $UPLOAD_DIR 2>/dev/null)" ]; then
        tar -czf "$BACKUP_DIR/files/upload_${TIMESTAMP}.tar.gz" -C "$PROJECT_DIR/data" upload/
        echo "  -> 文件备份完成: upload_${TIMESTAMP}.tar.gz"
        echo "  -> 文件大小: $(du -h "$BACKUP_DIR/files/upload_${TIMESTAMP}.tar.gz" | cut -f1)"
    else
        echo "  -> 上传目录为空，跳过"
    fi
}

# ---------- 清理过期备份 ----------
cleanup_old_backups() {
    echo ""
    echo "[清理] 删除 ${BACKUP_RETAIN_DAYS} 天前的备份..."
    find "$BACKUP_DIR" -type f -mtime +"$BACKUP_RETAIN_DAYS" -delete
    find "$BACKUP_DIR" -type d -empty -delete 2>/dev/null || true
    echo "  -> 清理完成"
}

# ---------- 执行备份 ----------
case "$BACKUP_TYPE" in
    full)
        backup_database
        backup_redis
        backup_files
        ;;
    db)
        backup_database
        ;;
    files)
        backup_files
        ;;
    *)
        echo "错误: 未知备份类型 '$BACKUP_TYPE'"
        echo "用法: $0 [full|db|files]"
        exit 1
        ;;
esac

# 清理过期备份
cleanup_old_backups

echo ""
echo "============================================"
echo "备份完成！"
echo "备份位置: $BACKUP_DIR"
echo "============================================"
echo ""
echo "当前备份文件列表:"
ls -lh "$BACKUP_DIR"/db/ 2>/dev/null | tail -5
ls -lh "$BACKUP_DIR"/files/ 2>/dev/null | tail -5
