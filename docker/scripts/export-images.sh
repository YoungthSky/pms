#!/bin/bash
# ============================================
# PMS Docker 镜像导出脚本（在有网机器上执行）
# 功能：拉取基础镜像 + 构建应用镜像 + 导出为离线包
# 用法：./export-images.sh [版本号]
# ============================================

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
VERSION="${1:-v1.0.0}"
EXPORT_DIR="$PROJECT_DIR/docker-export"

echo "============================================"
echo "PMS 离线部署包制作工具"
echo "版本: $VERSION"
echo "输出目录: $EXPORT_DIR"
echo "============================================"
echo ""

# ---------- Step 1: 构建后端 JAR ----------
echo "[Step 1/5] 构建后端 JAR 包..."
cd "$PROJECT_DIR"
mvn clean package -DskipTests -q
cp "$PROJECT_DIR/pms-admin/target/pms-admin.jar" "$PROJECT_DIR/docker/backend/pms-admin.jar"
echo "  -> JAR 构建完成"

# ---------- Step 2: 构建前端 ----------
echo "[Step 2/5] 构建前端..."
cd "$PROJECT_DIR/pms-ui-ts"
npm install --silent
npm run build:prod
rm -rf "$PROJECT_DIR/docker/nginx/dist"
cp -r "$PROJECT_DIR/pms-ui-ts/dist" "$PROJECT_DIR/docker/nginx/dist"
echo "  -> 前端构建完成"

# ---------- Step 3: 拉取基础镜像 ----------
echo "[Step 3/5] 拉取基础镜像..."
docker pull mysql:8.0
docker pull redis:7
docker pull eclipse-temurin:17-jre
docker pull nginx:latest
echo "  -> 基础镜像拉取完成"

# ---------- Step 4: 构建应用镜像 ----------
echo "[Step 4/5] 构建应用镜像..."
cd "$PROJECT_DIR"
docker build -t pms-backend:$VERSION -f docker/backend/Dockerfile docker/backend/
docker build -t pms-frontend:$VERSION -f docker/nginx/Dockerfile docker/nginx/
echo "  -> 应用镜像构建完成"

# ---------- Step 5: 导出离线包 ----------
echo "[Step 5/5] 导出离线部署包..."
mkdir -p "$EXPORT_DIR"

# 导出所有镜像（基础 + 应用）
echo "  导出 Docker 镜像（可能需要几分钟）..."
docker save \
    mysql:8.0 \
    redis:7 \
    pms-backend:$VERSION \
    pms-frontend:$VERSION \
    -o "$EXPORT_DIR/pms-images-${VERSION}.tar"

# 复制部署文件
echo "  复制部署配置文件..."
# 先删除旧的 docker/ 和 sql/ 目录，防止残留文件污染
rm -rf "$EXPORT_DIR/docker"
rm -rf "$EXPORT_DIR/sql"
cp "$PROJECT_DIR/docker-compose.yml" "$EXPORT_DIR/"
cp "$PROJECT_DIR/.env.docker" "$EXPORT_DIR/"
cp -r "$PROJECT_DIR/docker" "$EXPORT_DIR/docker"
cp -r "$PROJECT_DIR/sql" "$EXPORT_DIR/sql"
cp -r "$PROJECT_DIR/docker/scripts" "$EXPORT_DIR/scripts"

# 创建部署说明
cat > "$EXPORT_DIR/DEPLOY.txt" << EOF
============================================
PMS 离线部署包 - $VERSION
生成时间: $(date '+%Y-%m-%d %H:%M:%S')
============================================

部署步骤（在内网服务器上执行）:

1. 将整个 pms-export 目录复制到服务器 /opt/pms/

2. 进入目录:
   cd /opt/pms

3. 加载 Docker 镜像:
   docker load -i pms-images-${VERSION}.tar

4. 修改配置（重要！）:
   vi .env.docker
   - 修改所有默认密码
   - 根据服务器配置调整 JVM 内存

5. 启动服务:
   docker-compose --env-file .env.docker up -d

6. 查看状态:
   docker-compose --env-file .env.docker ps
   docker-compose --env-file .env.docker logs -f backend

7. 访问系统:
   http://服务器IP:80
   默认账号: admin / admin123

============================================
常用运维命令:

# 停止服务
docker-compose --env-file .env.docker down

# 重启后端
docker restart pms-backend

# 查看日志
docker logs -f --tail 100 pms-backend

# 数据备份
bash scripts/backup.sh full

# 数据还原
bash scripts/restore.sh list
bash scripts/restore.sh db <备份文件>

# 版本升级
bash scripts/upgrade.sh v2.0.0
============================================
EOF

echo ""
echo "============================================"
echo "离线部署包制作完成！"
echo ""
echo "输出目录: $EXPORT_DIR"
echo "文件列表:"
ls -lh "$EXPORT_DIR/"
echo ""
echo "总大小: $(du -sh "$EXPORT_DIR" | cut -f1)"
echo ""
echo "下一步: 将 $EXPORT_DIR 目录整体复制到内网服务器"
echo "============================================"
