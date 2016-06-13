# Extend Postgres to be used as an OpenIDM repo
# See https://hub.docker.com/_/postgres/


FROM postgres:9.6

#ADD 01_openidm.pgsql /docker-entrypoint-initdb.d/01_init.sql
#ADD default_schema_optimization.pgsql /docker-entrypoint-initdb.d/02_optimize.sql

ADD sql/* /docker-entrypoint-initdb.d/


