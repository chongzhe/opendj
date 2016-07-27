#!/usr/bin/env bash

# Container puts everything in /var/tmp
cd /var/tmp

source config/env.sh

echo "Home dir is $HOME"


echo $ADMIN_PWD >/root/.amadminpw
chmod  0400 /root/.amadminpw

# Wait for OpenAM to come up before configuring it
# args  $1 - server URL
# $2 - deployment URI
function wait_for_openam
{
	T="$1/openam/config/options.htm"

	until $(curl --output /dev/null --silent --head --fail $T); do
		echo "Waiting for OpenAM server at $T "
    sleep 5
	done
	# Sleep an additonal time in case DJ is not quite up yet
	echo "About to begin configuration"
	sleep 5
}


# Expand any env vars in env.sh
function do_template
{
	cat config/openam.properties | while read -r line; do
		while [[ "$line" =~ (\$\{[a-zA-Z_][a-zA-Z_0-9]*\}) ]] ; do
	        LHS=${BASH_REMATCH[1]}
	        RHS="$(eval echo "\"$LHS\"")"
	        line=${line//$LHS/$RHS}
	  done
    echo "$line" >>/tmp/am.properties
	done
	echo "Final AM Config file:"
	cat /tmp/am.properties
}


echo "Starting tomcat"
/usr/local/tomcat/bin/catalina.sh start

# template out env.sh vars
do_template
# OpenAM needs fqdn in hosts
echo "127.0.0.2  $HOSTNAME" >> /etc/hosts
wait_for_openam  $SERVER_URL
cd /var/tmp/ssoconfig
java -jar openam-configurator-tool*.jar -f /tmp/am.properties

cd /var/tmp/config

if [ -f ssoadm.txt ]; then
   echo "Running ssoadm batch commands"
   /root/admintools/ssoadm do-batch -u amadmin -f /root/.amadminpw -Z ssoadm.txt
fi


if [ -x post-config.sh ]; then
   echo "Executing post config script"
   ./post-config.sh
fi

if [ -f moressoadm.txt ]; then
   echo "Running additional ssoadm batch commands"
   /root/admintools/ssoadm do-batch -u amadmin -f /root/.amadminpw -Z moressoadm.txt
fi

echo "Stopping tomcat"


/usr/local/tomcat/bin/catalina.sh stop


echo "done"
