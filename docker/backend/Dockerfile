# ============================================
# PMS 后端 Dockerfile
# 基于 Eclipse Temurin JRE 17（离线构建）
# ============================================
FROM eclipse-temurin:17-jre

LABEL maintainer="PMS Team"
LABEL description="四川省甘孜监狱执法证据保全系统 - 后端服务"

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 创建应用目录和上传文件目录
RUN mkdir -p /pms/app /pms/uploadPath /pms/logs

# 设置工作目录
WORKDIR /pms/app

# 复制构建好的 JAR 包
COPY pms-admin.jar /pms/app/pms-admin.jar

# 暴露端口
EXPOSE 8080

# JVM 参数（可根据服务器内存调整）
ENV JAVA_OPTS="-Xms512m -Xmx1024m -XX:+UseG1GC -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/pms/logs/ -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8"

# 启动命令
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /pms/app/pms-admin.jar --spring.profiles.active=docker"]
