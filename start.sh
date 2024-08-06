#!/bin/bash

chmod -R 777 /cloudrve

cat > /cloudreve/pgbouncer.ini <<-EOF
[databases]
$DB_NAME = host=$DB_HOST port=$DB_PORT dbname=$DB_NAME

[pgbouncer]
listen_port = 37721
listen_addr = 127.0.0.1
auth_type = md5
auth_file = /cloudreve/userlist.txt
logfile = /cloudreve/pgbouncer.log
pidfile = /cloudreve/pgbouncer.pid
admin_users = postgres
stats_users = pgmon
max_client_conn = 80
default_pool_size = 20
reserve_pool_size = 5
dns_max_ttl = 15
ignore_startup_parameters = extra_float_digits 
client_tls_sslmode=disable
client_tls_sslmode=require
EOF

cat > /cloudreve/userlist.txt <<-EOF
"$DB_USER" "endpoint=$DB_ENDPOINT\$$DB_PASSWORD"
EOF

echo "PgBouncer配置文件创建完毕"

touch /cloudreve/pgbouncer.log

chmod 777 /cloudreve/pgbouncer.log

echo "PgBouncer依赖文件创建完毕"

pgbouncer -d -u nobody /cloudreve/pgbouncer.ini

echo "PgBouncer开始运行"

cat > /cloudreve/conf.ini <<-EOF
[System]
Debug = false
Mode = master
Listen = :5212
SessionSecret = $SESSION_SECRET
HashIDSalt = $HASH_ID_SALT
[Database]
Type = postgres
Port = 37721
User = $DB_USER
Password = endpoint=$DB_ENDPOINT\$$DB_PASSWORD
Host = 127.0.0.1
Name = $DB_NAME
TablePrefix = cd
Charset = utf8
EOF

chmod +x /cloudreve/cloudreve

echo "准备运行Cloudreve"

./cloudreve
