FROM mysql:5.7.24

# Listening port
EXPOSE 3306

# Copy the settings
ADD ./.deploy/my.cnf /etc/
RUN chmod 644 /etc/my.cnf

# Initializing DB for granting access to clients from another Host (aka Docker container):
COPY ./.deploy/init.sh /docker-entrypoint-initdb.d/init.sh
RUN chmod 755 /docker-entrypoint-initdb.d/init.sh
RUN touch /docker-entrypoint-initdb.d/privileges.sql
RUN chmod 777 /docker-entrypoint-initdb.d/privileges.sql
