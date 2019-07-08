#!/usr/bin/env bash

# echo "USE alignment;" > /docker-entrypoint-initdb.d/privileges.sql
# allow root user to connect login as non-localohst (needed for connection e.g. Sequel Pro through ssh)
echo "GRANT ALL ON *.* to root@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> /docker-entrypoint-initdb.d/privileges.sql
echo "FLUSH PRIVILEGES;" >> /docker-entrypoint-initdb.d/privileges.sql
