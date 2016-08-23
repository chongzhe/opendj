#!/usr/bin/env bash



if [ -d $"$CUSTOM_CONF_DIR" ]; then
   echo "Copying custom conf from $CUSTOM_CONF_DIR to /opt/openresty"
   cp -r $CUSTOM_CONF_DIR/* /opt/openresty
fi

exec nginx -g "daemon off; error_log /dev/stderr info;"
