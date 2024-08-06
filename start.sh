#!/bin/bash

uname -a

cat > /cloudreve/pgbouncer.ini <<-EOF
[databases]
koyebdb = $DB_HOST port=$DB_PORT dbname=$DB_NAME user=$DB_USER

[pgbouncer]
listen_port = 7721
listen_addr = 127.0.0.1
auth_type = md5
auth_file = /cloudreve/userlist.txt
logfile = /cloudreve/pgbouncer.log
pidfile = /cloudreve/pgbouncer.pid
admin_users = postgres
stats_users = pgmon
server_reset_query = DISCARD ALL
server_check_query = select 1
server_check_delay = 30
max_client_conn = 80
default_pool_size = 20
reserve_pool_size = 5
dns_max_ttl = 15
EOF

cat > /cloudreve/userlist.txt <<-EOF
"$DB_USER" "$DB_PASSWORD"
EOF

echo "PgBouncer配置文件创建完毕"

touch /cloudreve/pgbouncer.log

chmod 777 /cloudreve/pgbouncer.log

touch /cloudreve/pgbouncer.pid

chmod 777 /cloudreve/pgbouncer.pid

echo "PgBouncer依赖文件创建完毕"

pgbouncer -R -d /cloudreve/pgbouncer.ini

echo "PgBouncer开始运行"

cat > /cloudreve/conf.ini <<-EOF
[System]
Debug = false
Mode = master
Listen = :5212
SessionSecret = DR3c3K0P6ei6rLJDm8ffNdV4uLs2jAXnOvWDmmDPW7C5KhYtuRijM6N6x8KJMqcc
HashIDSalt = 4brAt3NOAOmNo79S0OoU3BADYVRSrrEuRbrudTSLPDHNQ25C2UN3cwsPfJMA0wUr
[Database]
Type = postgres
Port = 7721
User = $DB_USER
Password = $DB_PASSWORD
Host = 127.0.0.1
Name = $DB_NAME
TablePrefix = cd
Charset = utf8
EOF

chmod +x /cloudreve/cloudreve

echo "准备运行Cloudreve"

./cloudreve
