# ============================================
# PMS 前端 Dockerfile
# 基于 Nginx（离线构建）
# ============================================
FROM nginx:latest

LABEL maintainer="PMS Team"
LABEL description="四川省甘孜监狱执法证据保全系统 - 前端服务"

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 删除默认配置和页面
RUN rm -rf /etc/nginx/nginx.conf /usr/share/nginx/html/*

# 复制自定义 Nginx 配置
COPY nginx.conf /etc/nginx/nginx.conf

# 复制前端构建产物
COPY dist/ /usr/share/nginx/html/

# 暴露端口
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
