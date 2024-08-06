FROM alpine:3.20

WORKDIR /cloudreve

COPY . .

RUN apk update \

    && apk add --no-cache tzdata wget pgbouncer libpq-dev \

    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \

    && echo "Asia/Shanghai" > /etc/timezone \

    && wget https://github.com/cloudreve/Cloudreve/releases/download/3.8.3/cloudreve_3.8.3_linux_amd64.tar.gz \

    && tar -zxvf ./cloudreve_3.8.3_linux_amd64.tar.gz \

    && chmod +x ./start.sh

EXPOSE 5212

ENTRYPOINT ["/cloudreve/start.sh"]
