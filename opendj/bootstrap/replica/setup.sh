#!/usr/bin/env bash
# Example setup.sh for DJ replication

echo "Setting up  OpenDJ instance"


DJ_HOSTNAME=${DJ_HOSTNAME:-localhost}
PASSWORD=${PASSWORD:-password}
echo "Hostname is $DJ_HOSTNAME"


cd /opt/opendj


/opt/opendj/setup --cli -p 389 --ldapsPort 636 --enableStartTLS --generateSelfSignedCertificate \
  --sampleData 5 --baseDN "dc=example,dc=com" -h $DJ_HOSTNAME --rootUserPassword password \
  --acceptLicense --no-prompt \
  --doNotStart



# If DJ_REPLICA_HOST is set, configure replication
# This is the hostname of the other DJ instance we want to replicate.
# This only needs to be run once on the first master.
if [ -v DJ_REPLICA_HOST ]; then

bin/start-ds

echo "enabling replication"

# todo: test if second host is reachable
ping -c 1 $DJ_REPLICA_HOST

bin/dsreplication enable --host1 $DJ_HOSTNAME --port1 4444\
  --bindDN1 "cn=directory manager" \
  --bindPassword1 $PASSWORD --replicationPort1 8989 \
  --host2 $DJ_REPLICA_HOST --port2 4444 --bindDN2 "cn=directory manager" \
  --bindPassword2 $PASSWORD --replicationPort2 8989 \
  --adminUID admin --adminPassword $PASSWORD --baseDN "dc=example,dc=com" -X -n

echo "initializing replication"

bin/dsreplication initialize --baseDN "dc=example,dc=com" \
  --adminUID admin --adminPassword password \
  --hostSource $DJ_HOSTNAME --portSource 4444 \
  --hostDestination $DJ_REPLICA_HOST --portDestination 4444 -X -n

# run.sh expects it will be stopped
bin/stop-ds


fi