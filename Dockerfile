FROM ubuntu:18.04

WORKDIR /cloudreve

COPY . .

RUN apt-get update -y && \
    apt install wget tzdata  -y && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    wget https://github.com/cloudreve/Cloudreve/releases/download/3.8.3/cloudreve_3.8.3_linux_amd64.tar.gz && \
    tar -zxvf ./cloudreve_3.8.3_linux_amd64.tar.gz && \
    chmod +x ./cloudreve

EXPOSE 5212

CMD printf "[System]\nDebug = false\nMode = master\nListen = :5212\nSessionSecret = ${SessionSecret}\nHashIDSalt = ${HashIDSalt}\n[Database]\nType = postgres\nPort = 5432\nUser = ${User}\nPassword = ${Password}\nHost = ${Host}\nName = ${Name}\nTablePrefix = cd\nCharset = utf8\n" > ./conf.ini && ./cloudreve
