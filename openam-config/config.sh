#!/usr/bin/env bash
# Run the configurator and any other config
# Assumes that /var/tmp/openam.properties has been placed in the container filesystem
# Container puts everything in


cd /var/tmp/ssoconfig


# Where OpenAM is in the k8s cluster. The default is openam
SERVER_URL=${OPENAM_INSTANCE:-http://openam:80}
URI=${SERVER_URI:-/openam}

# Alive check
ALIVE="${SERVER_URL}/${URI}/isAlive.jsp"
# Config page. This comes up if AM is not configured
CONFIG_URL="${SERVER_URL}${URI}/config/options.htm"

# Wait for OpenAM to come up before configuring it
function wait_for_openam
{
   response="000"

	while true
	do
		echo "Waiting for OpenAM server at ${CONFIG_URL} "
		response=$(curl --write-out %{http_code} --silent --output /dev/null ${CONFIG_URL} )

      if [ ${response} == "302" ]; then
         echo "It looks like OpenAM is already configured. Will not reconfigure"
         exit 0
      fi
      if [ ${response} == "200" ];
      then
         echo "OpenAM web app is up"
         break
      fi

      echo "response code ${response}. Will continue to wait"
      sleep 5
   done

	# Sleep additional time in case DJ is not quite up yet
	echo "About to begin configuration in 30 seconds"
	sleep 30
}



wait_for_openam


if [ ! -f /var/tmp/config/openam.properties ]; then
   echo "openam.properties not found, can not continue"
   exit 1
fi


echo "Running Configurator"
java -jar openam-configurator-tool*.jar -f /var/tmp/config/openam.properties

# Todo
# When amster is done - add additional commands here..:

echo "done"