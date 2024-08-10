FROM alpine:latest

WORKDIR /cloudreve

COPY . .

RUN tar -zxvf ./cloudreve_3.8.3_linux_amd64.tar.gz

EXPOSE 5212

ENTRYPOINT ["./cloudreve"]
