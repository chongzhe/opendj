#!/usr/bin/env bash
# This is a minimal start script for OpenIDM that hard codes a lot of
# path and logging params. The idea is that in Docker we always know
# where things are installed so we don't need the flexibility
# of the more complex startup.sh script that ships with OpenIDM

CONFIG=${OPENIDM_CUSTOM_CONF:-.}
JAVA_OPTS=${JAVA_OPTS:--Xmx1024m -Xms1024m}


echo "Starting Openidm with config $CONFIG and java options $JAVA_OPTS"


java \
 -Djava.util.logging.config.file=/opt/openidm/logging.properties \
  ${JAVA_OPTS} \
   -Djava.endorsed.dirs= \
 -classpath /opt/openidm/bin/*:/opt/openidm/framework/* \
 -Dopenidm.system.server.root=/opt/openidm \
 -Djava.awt.headless=true \
 org.forgerock.commons.launcher.Main \
  -c /opt/openidm/bin/launcher.json \
  -p ${CONFIG}