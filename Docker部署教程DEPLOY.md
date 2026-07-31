# PMS 内网离线部署指南

> 四川省甘孜监狱执法证据保全系统 — Docker 离线部署与运维手册

---

## 一、方案概述

本方案采用 **Docker Compose** 容器化部署，专为**无互联网的内网环境**设计：

- 在有网开发机上完成所有构建，导出离线部署包
- 通过 U 盘/移动硬盘将部署包传输到内网服务器
- 内网服务器加载镜像后一键启动，无需任何网络访问

### 服务架构

| 服务 | 容器名 | 镜像 | 端口 | 说明 |
|------|--------|------|------|------|
| MySQL 8.0 | pms-mysql | mysql:8.0 | 3306 | 业务数据库 |
| Redis 7 | pms-redis | redis:7 | 6379 | 缓存/会话 |
| 后端 | pms-backend | pms-backend:版本号 | 8080 | Spring Boot 应用 |
| 前端 | pms-frontend | pms-frontend:版本号 | 80 | Nginx 静态资源+反向代理 |

---

## 二、部署文件结构

```
pms/
├── docker-compose.yml                          # 服务编排配置
├── .env.docker                                 # 环境变量（密码、端口、路径）
├── pms-admin/src/main/resources/
│   └── application-docker.yml                  # Docker 环境 Spring Boot 配置
├── docker/
│   ├── backend/
│   │   └── Dockerfile                          # 后端镜像（基于 eclipse-temurin:17-jre）
│   ├── nginx/
│   │   ├── Dockerfile                          # 前端镜像（基于 nginx:latest）
│   │   └── nginx.conf                          # Nginx 反向代理配置
│   ├── mysql/
│   │   ├── init/
│   │   │   └── 00-init.sql                     # 数据库初始化（首次启动自动执行）
│   │   └── migration/                          # 版本升级数据库迁移脚本目录
│   │       └── README.md
│   └── scripts/
│       ├── export-images.sh                    # 【有网机器】制作离线部署包
│       ├── deploy.sh                           # 【内网服务器】一键部署
│       ├── backup.sh                           # 数据备份
│       ├── restore.sh                          # 数据还原
│       └── upgrade.sh                          # 版本升级
├── sql/                                        # 数据库初始化 SQL
│   ├── ry_20260417.sql                         # 系统基础表
│   ├── quartz.sql                              # 定时任务表
│   └── pm/                                     # 业务模块表
│       ├── 罪犯基本信息表.sql
│       └── 就医记录表.sql
└── data/                                       # 运行时数据（自动生成，不入Git）
    ├── mysql/                                  # MySQL 数据文件
    ├── redis/                                  # Redis 持久化文件
    ├── upload/                                 # 业务上传文件
    ├── logs/                                   # 应用日志
    └── backup/                                 # 备份文件
        ├── db/                                 # 数据库备份
        ├── files/                              # 文件备份
        └── redis/                              # Redis 备份
```

---

## 三、离线部署流程

### 第一步：在有网开发机上制作部署包

**前提条件：** 开发机已安装 JDK 17、Maven 3.6+、Node.js、Docker

```bash
cd /path/to/pms

# 一键构建（自动完成：Maven打包 → 前端构建 → 拉取镜像 → 构建应用镜像 → 导出）

#.sh 脚本是给内网 Linux 服务器用的（备份/还原/升级/部署），
bash docker/scripts/export-images.sh v1.0.0

#Window开发机上的打包操作使用 docker/scripts/export-images.ps1 （备份/还原/升级/部署），
docker/scripts/export-images.ps1 版本
```

脚本自动执行以下操作：
1. `mvn clean package -DskipTests` — 构建后端 JAR
2. `npm install && npm run build:prod` — 构建前端
3. `docker pull` — 拉取 mysql:8.0、redis:7、eclipse-temurin:17-jre、nginx:latest
4. `docker build` — 构建 pms-backend 和 pms-frontend 应用镜像
5. `docker save` — 导出所有镜像为 tar 文件

**输出：** 项目根目录下生成 `docker-export/` 目录，即为完整离线部署包。

### 第二步：传输到内网服务器

将 `docker-export/` 目录整体复制到 U 盘/移动硬盘，传输到内网服务器：

```bash
# 在内网服务器上
mkdir -p /opt/pms
cp -r /mnt/usb/docker-export/* /opt/pms/
cd /opt/pms
```

### 第三步：内网服务器环境准备

内网服务器需要预先安装 Docker 和 Docker Compose（离线安装）：

**安装 Docker：**
```bash
# 1. 在有网机器下载 Docker 离线包:
#    https://download.docker.com/linux/static/stable/x86_64/docker-24.0.7.tgz

# 2. 复制到内网服务器后:
tar -xzf docker-24.0.7.tgz
cp docker/* /usr/bin/

# 3. 创建 systemd 服务
cat > /etc/systemd/system/docker.service << 'EOF'
[Unit]
Description=Docker Application Container Engine
After=network-online.target

[Service]
ExecStart=/usr/bin/dockerd
ExecReload=/bin/kill -s HUP $MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# 4. 启动
systemctl daemon-reload
systemctl start docker
systemctl enable docker
```

**安装 Docker Compose：**
```bash
# 1. 在有网机器下载:
#    https://github.com/docker/compose/releases/download/v2.24.0/docker-compose-linux-x86_64

# 2. 复制到内网服务器:
cp docker-compose-linux-x86_64 /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

### 第四步：修改配置

**部署前必须修改默认密码！**

```bash
vi /opt/pms/.env.docker
```

需要修改的关键配置：

| 配置项 | 默认值 | 说明 |
|--------|--------|------|
| `MYSQL_ROOT_PASSWORD` | pms_root_2026 | MySQL root 密码 |
| `MYSQL_PASSWORD` | pms_db_2026 | MySQL 应用密码 |
| `REDIS_PASSWORD` | pms_redis_2026 | Redis 密码 |
| `DRUID_PASSWORD` | pms_druid_2026 | Druid 监控密码 |
| `JAVA_OPTS` | -Xms512m -Xmx1024m | JVM 内存（按服务器配置调整） |
| `FRONTEND_PORT` | 80 | 前端访问端口 |

### 第五步：一键部署

```bash
cd /opt/pms
bash scripts/deploy.sh
```

脚本自动执行：加载镜像 → 创建数据目录 → 启动全部服务 → 健康检查

### 第六步：验证

```bash
# 查看服务状态
docker-compose --env-file .env.docker ps

# 查看后端启动日志
docker logs -f --tail 200 pms-backend
```

浏览器访问：`http://服务器IP:80`

默认管理员账号：`admin` / `admin123`

---

## 四、日常运维

### 常用命令

```bash
cd /opt/pms

# 查看所有服务状态
docker-compose --env-file .env.docker ps

# 启动所有服务
docker-compose --env-file .env.docker up -d

# 停止所有服务
docker-compose --env-file .env.docker down

# 重启所有服务
docker-compose --env-file .env.docker restart

# 重启单个服务
docker restart pms-backend

# 查看后端日志（实时）
docker logs -f --tail 200 pms-backend

# 查看 MySQL 日志
docker logs -f --tail 100 pms-mysql

# 进入 MySQL 命令行
docker exec -it pms-mysql mysql -upms -p
```

---

## 五、数据备份与还原

### 5.1 手动备份

```bash
# 全量备份（数据库 + Redis + 上传文件）
bash scripts/backup.sh full

# 仅备份数据库
bash scripts/backup.sh db

# 仅备份上传文件
bash scripts/backup.sh files
```

备份文件保存在 `data/backup/` 目录下，按类型分子目录存放，自动压缩并附带时间戳。

### 5.2 定时自动备份（推荐）

```bash
# 编辑定时任务
crontab -e

# 添加以下行（每天凌晨2点自动备份）
0 2 * * * /opt/pms/scripts/backup.sh full >> /opt/pms/data/logs/backup.log 2>&1
```

备份默认保留 **30 天**，过期自动清理（可在 `.env.docker` 中修改 `BACKUP_RETAIN_DAYS`）。

### 5.3 数据还原

```bash
# 查看所有可用备份
bash scripts/restore.sh list

# 还原数据库
bash scripts/restore.sh db ./data/backup/db/pms_full_20260731_020000.sql.gz

# 还原上传文件
bash scripts/restore.sh files ./data/backup/files/upload_20260731_020000.tar.gz

# 还原 Redis
bash scripts/restore.sh redis ./data/backup/redis/dump_20260731_020000.rdb
```

> 还原操作会有确认提示，输入 `yes` 后执行。还原前会自动保存当前数据以防误操作。

---

## 六、版本升级

### 6.1 升级准备（在有网开发机上）

```bash
# 1. 构建新版本
bash docker/scripts/export-images.sh v2.0.0
```

### 6.2 传输升级包到内网

将以下文件复制到内网服务器对应目录：

| 文件 | 目标路径 |
|------|----------|
| 新版 JAR 包 | `/opt/pms/docker/backend/pms-admin.jar` |
| 新版前端 dist/ | `/opt/pms/docker/nginx/dist/` |
| 数据库迁移 SQL（如有） | `/opt/pms/docker/mysql/migration/V2.0.0__描述.sql` |

### 6.3 执行升级

```bash
cd /opt/pms
bash scripts/upgrade.sh v2.0.0
```

升级脚本自动执行：
1. **备份**当前全部数据
2. **停止**所有服务
3. **更新**版本号配置
4. **重建**应用镜像
5. **执行**数据库迁移脚本（如有）
6. **启动**新版本服务
7. **健康检查**

### 6.4 数据库迁移脚本规范

迁移脚本放在 `docker/mysql/migration/` 目录，命名格式：

```
V{版本号}__{描述}.sql
```

示例：
- `V2.0.0__add_criminal_photo_column.sql`
- `V2.0.0__create_medical_record_table.sql`

### 6.5 升级回滚

如升级后发现问题：

```bash
# 1. 停止服务
docker-compose --env-file .env.docker down

# 2. 修改版本号为旧版本
vi .env.docker  # 将 PMS_VERSION 改回 v1.0.0

# 3. 还原数据库
bash scripts/restore.sh db ./data/backup/db/pms_full_升级前时间戳.sql.gz

# 4. 重新启动
docker-compose --env-file .env.docker up -d
```

---

## 七、灾备设计

### 数据持久化策略

| 数据类型 | 容器内路径 | 宿主机路径 | 持久化方式 |
|----------|-----------|-----------|-----------|
| MySQL 数据 | /var/lib/mysql | ./data/mysql | Docker Volume |
| Redis 数据 | /data | ./data/redis | AOF + RDB |
| 上传文件 | /pms/uploadPath | ./data/upload | Docker Volume |
| 应用日志 | /pms/logs | ./data/logs | Docker Volume |
| 备份文件 | /backup | ./data/backup | Docker Volume |

> **核心原则：** 所有业务数据存储在宿主机 `./data/` 目录下，即使删除全部容器和镜像，数据不会丢失。

### 灾难恢复步骤

如果服务器完全重装（Docker 数据全部丢失），但 `data/` 目录备份存在：

```bash
# 1. 重新安装 Docker（见第三节）
# 2. 重新部署（见第三节）
# 3. 停止服务
docker-compose --env-file .env.docker down

# 4. 将备份的 data/mysql 目录恢复到 ./data/mysql
# 5. 将备份的 data/upload 目录恢复到 ./data/upload

# 6. 重新启动（MySQL 检测到已有数据会跳过初始化）
docker-compose --env-file .env.docker up -d
```

### 建议的备份策略

| 频率 | 内容 | 保留时间 |
|------|------|----------|
| 每日 | 数据库全量备份 | 30 天 |
| 每周 | 上传文件打包 | 30 天 |
| 升级前 | 全量备份（自动） | 永久（手动管理） |
| 每月 | 整个 data/ 目录异地拷贝 | 按需 |

---

## 八、故障排查

### 后端启动失败

```bash
# 查看日志
docker logs pms-backend

# 常见原因：
# 1. MySQL 未就绪 — 等待 MySQL 健康检查通过
# 2. Redis 连接失败 — 检查密码配置是否一致
# 3. 内存不足 — 调整 .env.docker 中 JAVA_OPTS
```

### 前端无法访问

```bash
# 检查 Nginx 状态
docker logs pms-frontend

# 检查后端是否正常
curl http://localhost:8080/

# 常见原因：
# 1. 后端未启动完成 — 等待30秒后重试
# 2. 端口冲突 — 修改 .env.docker 中 FRONTEND_PORT
```

### 数据库连接失败

```bash
# 检查 MySQL 状态
docker exec pms-mysql mysqladmin ping -uroot -p

# 检查数据库是否存在
docker exec -it pms-mysql mysql -uroot -p -e "SHOW DATABASES;"

# 手动重新初始化（危险：会清除数据）
docker-compose --env-file .env.docker down
rm -rf data/mysql
docker-compose --env-file .env.docker up -d
```

### 文件上传失败

```bash
# 检查上传目录权限
ls -la data/upload/

# 检查 Nginx 上传大小限制（已配置 1000m）
docker exec pms-frontend cat /etc/nginx/nginx.conf | grep client_max_body
```

---

## 九、安全建议

1. **修改所有默认密码** — 部署前必须修改 `.env.docker` 中的密码
2. **限制端口暴露** — 生产环境建议只暴露 80 端口，注释掉 3306/6379/8080 的端口映射
3. **定期备份** — 配置 crontab 定时备份
4. **备份异地存储** — 定期将 `data/backup/` 拷贝到其他物理介质
5. **关闭 Swagger** — Docker 环境已默认关闭（application-docker.yml）
6. **日志监控** — 定期检查 `data/logs/` 下的异常日志

---

## 十、环境变量速查

`.env.docker` 完整配置说明：

```bash
# 版本标识（升级时修改）
PMS_VERSION=v1.0.0

# MySQL
MYSQL_ROOT_PASSWORD=你的root密码
MYSQL_DATABASE=pms
MYSQL_USER=pms
MYSQL_PASSWORD=你的应用密码
MYSQL_DATA_DIR=./data/mysql
MYSQL_PORT=3306

# Redis
REDIS_PASSWORD=你的redis密码
REDIS_DATA_DIR=./data/redis
REDIS_PORT=6379

# 后端
JAVA_OPTS=-Xms512m -Xmx1024m -XX:+UseG1GC
BACKEND_PORT=8080
UPLOAD_DATA_DIR=./data/upload
LOG_DATA_DIR=./data/logs

# 前端
FRONTEND_PORT=80

# Druid 监控
DRUID_USERNAME=admin
DRUID_PASSWORD=你的druid密码

# 备份
BACKUP_DIR=./data/backup
BACKUP_RETAIN_DAYS=30
```
