FROM ubuntu:22.04

WORKDIR /cloudreve

COPY . .

RUN apt update \
    
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata pgbouncer libpq-dev \

    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \

    && tar -zxvf ./cloudreve_3.8.3_linux_amd64.tar.gz \

    && chmod +x ./start.sh

EXPOSE 5212

ENTRYPOINT ["/cloudreve/start.sh"]
