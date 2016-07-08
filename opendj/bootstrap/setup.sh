#!/usr/bin/env bash
# Default setup script

echo "Setting up default OpenDJ instance"


/opt/opendj/setup --cli -p 389 --ldapsPort 636 --enableStartTLS --generateSelfSignedCertificate \
  --sampleData 5 --baseDN $BASE_DN -h localhost --rootUserPassword "$PASSWORD" \
  --acceptLicense --no-prompt
