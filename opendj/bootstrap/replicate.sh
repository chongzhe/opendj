#!/usr/bin/env bash
# Replicate to the master server hostname defined in $1
# If that server is ourself this is a no-op

MASTER=$1
echo "Setting up replication from $HOSTNAME to $MASTER"


if [ ${HOSTNAME} == ${MASTER} ]; then
 echo "We are the master. Skipping replication setup to ourself"
 exit 0
fi


echo "enabling replication"

# todo: Replace with command to test for master being reachable and up
# This is hacky....
echo "Will sleep for a bit to ensure master is up"

sleep 15

bin/dsreplication enable --host1 $HOSTNAME --port1 4444 \
  --bindDN1 "cn=directory manager" \
  --bindPassword1 $PASSWORD --replicationPort1 8989 \
  --host2 $MASTER --port2 4444 --bindDN2 "cn=directory manager" \
  --bindPassword2 $PASSWORD --replicationPort2 8989 \
  --adminUID admin --adminPassword $PASSWORD --baseDN $BASE_DN -X -n

echo "initializing replication"

bin/dsreplication initialize --baseDN $BASE_DN \
  --adminUID admin --adminPassword $PASSWORD \
  --hostSource $HOSTNAME --portSource 4444 \
  --hostDestination $MASTER --portDestination 4444 -X -n

