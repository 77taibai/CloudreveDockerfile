FROM ubuntu:18.04

WORKDIR /cloudreve

COPY . .

ARG SessionSecret
ARG HashIDSalt
ARG User
ARG Password
ARG Host
ARG Name

RUN apt-get update -y && \
    apt install aria2 wget tzdata  -y && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    wget https://github.com/cloudreve/Cloudreve/releases/download/3.8.3/cloudreve_3.8.3_linux_amd64.tar.gz && \
    tar -zxvf ./cloudreve_3.8.3_linux_amd64.tar.gz && \
    mkdir ./aria2D && \
    touch ./aria2.session && \
    echo -e "[System]\nDebug = false\nMode = master\nListen = :5212\nSessionSecret = ${SessionSecret}\nHashIDSalt = ${HashIDSalt}\n[Database]\nType = postgres\nPort = 5432\nUser = ${User}\nPassword = ${Password}\nHost = ${Host}\nName = ${Name}\nTablePrefix = cd\nCharset = utf8\n" > ./conf.ini && \
    chmod +x ./cloudreve

EXPOSE 5212

CMD aria2c --conf-path=/cloudreve/aria2.conf & ./cloudreve