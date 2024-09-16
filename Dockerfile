FROM ubuntu:22.04

WORKDIR /cloudreve

COPY . .

RUN apt update \
    && apt install nginx ca-certificates -y \
	&& useradd -M -s /sbin/nologin nginx \
	&& cp nginx.conf /etc/nginx/nginx.conf \
    && tar -zxvf ./cloudreve_3.8.3_linux_amd64.tar.gz \
    && chmod +x ./start.sh \
    && update-ca-certificates

EXPOSE 5212

ENTRYPOINT ["/cloudreve/start.sh"]
