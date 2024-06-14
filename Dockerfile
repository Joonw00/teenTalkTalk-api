# 기본 이미지로 Node.js를 사용합니다.
FROM node:latest

# 앱 디렉토리를 생성하고 작업 디렉토리로 설정합니다.
WORKDIR /usr/src/app

# 앱 소스를 컨테이너의 작업 디렉토리로 복사합니다.
COPY app/package*.json ./
COPY app/ ./

# npm install을 작업 디렉토리에서 직접 실행합니다.
RUN npm install

# 앱을 실행합니다.
CMD ["npm", "start"]
