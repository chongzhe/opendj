#!/usr/bin/env bash
# Default setup script

echo "Setting up default OpenDJ instance"

PW=`cat $DIR_MANAGER_PW_FILE`
PASSWORD=${PW:-password}

echo "Password is $PASSWORD"

PASSWORD=`cat $DIR_MANAGER_PW_FILE`

echo /opt/opendj/setup --cli -p 389 --ldapsPort 636 --enableStartTLS --generateSelfSignedCertificate \
  --sampleData 5 --baseDN "dc=example,dc=com" -h localhost --rootUserPassword "$PASSWORD" \
  --acceptLicense --no-prompt --doNotStart

/opt/opendj/setup --cli -p 389 --ldapsPort 636 --enableStartTLS --generateSelfSignedCertificate \
  --sampleData 5 --baseDN "dc=example,dc=com" -h localhost --rootUserPassword "$PASSWORD" \
  --acceptLicense --no-prompt --doNotStart

# run.sh assumes DJ must be started - so make sure setup.sh shuts it down
