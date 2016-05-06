#!/usr/bin/env bash
# Default setup script

echo "Setting up default OpenDJ instance"

/opt/opendj/setup --cli -p 389 --ldapsPort 636 --enableStartTLS --generateSelfSignedCertificate \
  --sampleData 5 --baseDN "dc=example,dc=com" -h localhost --rootUserPassword password \
  --acceptLicense --no-prompt --doNotStart


# run.sh assumes DJ must be started - so make sure setup.sh shuts it down
