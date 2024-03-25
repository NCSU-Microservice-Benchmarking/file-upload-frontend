# 使用node镜像作为基础镜像
FROM node:14

# 设置工作目录
WORKDIR /app

# 复制`package.json`和`package-lock.json`文件
COPY package*.json ./

# 安装项目依赖
RUN npm install

# 全局安装serve用于运行构建后的静态文件
RUN npm install -g serve

# 复制项目文件到容器中
COPY . .

# 构建应用
RUN npm run build

# 暴露容器的8081端口
EXPOSE 8081

# 运行serve来提供应用，指定端口为8081
CMD ["serve", "-s", "dist", "-l", "8081"]
