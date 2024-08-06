FROM alpine:latest

WORKDIR /cloudreve

COPY . .

RUN apk update \
    
    && apk add tzdata pgbouncer dos2unix libpq-dev \

    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \

    && echo "Asia/Shanghai" > /etc/timezone \

    && tar -zxvf ./cloudreve_3.8.3_linux_amd64.tar.gz \

    && dos2unix start.sh \

    && chmod +x ./start.sh

EXPOSE 5212

ENTRYPOINT ["/cloudreve/start.sh"]
