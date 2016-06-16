#!/usr/bin/env bash
# This is a minimal start script for OpenIDM that hard codes a lot of
# path and logging params. The idea is that in Docker we always know
# where things are installed so we don't need the flexibility
# of the more complex startup.sh script that ships with OpenIDM

cd /opt/openidm

CONFIG=${OPENIDM_CUSTOM_CONF:-.}
JAVA_OPTS=${JAVA_OPTS:--Xmx1024m -Xms1024m}


echo "Starting Openidm with config $CONFIG and java options $JAVA_OPTS"

# Hack to remove orient db repo if there is another repo defined
if [ -f /opt/openidm/conf/datasource.jdbc-default.json ]; then
   echo "Removing OrientDB repo config repo.orientdb.json, because you are using another repo datasource"
   rm /opt/openidm/conf/repo.orientdb.json

   # Another hack for https://bugster.forgerock.org/jira/browse/OPENIDM-5468
   # If we are using a non OrientDB there is a good chance that K8S might
   # start up OpenIDM before the DB. We should sleep a bit.
   echo "Sleeping a bit to ensure the repo DB is up"
   sleep 20
fi

exec java \
 -Djava.util.logging.config.file=/opt/openidm/logging.properties \
  ${JAVA_OPTS} \
   -Djava.endorsed.dirs= \
 -classpath /opt/openidm/bin/*:/opt/openidm/framework/* \
 -Dopenidm.system.server.root=/opt/openidm \
 -Djava.awt.headless=true \
 org.forgerock.commons.launcher.Main \
  -c /opt/openidm/bin/launcher.json \
  -p ${CONFIG}