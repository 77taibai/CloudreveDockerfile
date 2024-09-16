#!/bin/bash

chmod -R 777 /cloudreve

echo "目录权限设置完毕"

cat > /cloudreve/conf.ini <<-EOF
[System]
Debug = false
Mode = master
Listen = :5212
SessionSecret = $SESSIONSECRET
HashIDSalt = $HASHIDSALT

[Database]
Type = postgres
Port = $PORT
User = $DBUSER
Password = $DBPASSWORD
Host = $DBURL
Name = $DBNAME
TablePrefix = cd
Charset = utf8
EOF

echo "Cloudreve配置文件生成完毕"

echo "准备运行Nginx"

service nginx start

echo "准备运行Cloudreve"

chmod +x /cloudreve/cloudreve

cd /cloudreve

./cloudreve