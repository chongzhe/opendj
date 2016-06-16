#!/usr/bin/env bash
# Run the OpenDJ server
# The idea is to consolidate all of the writable DJ directories to
# a single instance directory root, and update DJ's instance.loc file to point to that root
# This allows us to to mount a data volume on that root which  gives us
# persistence across restarts of OpenDJ.
# For Docker - mount a data volume on /opt/opendj/instances/instance1.
# For Kubernetes mount a PV
# To "prime" the sytem the first time DJ is run, we copy in a skeleton
# DJ instance from the instances/template directory that was created in the Dockerfile

cd /opt/opendj


# Instance dir does not exist?
if [ ! -d ./data/config ] ; then
  echo "Instance data Directory is empty. Creating new DJ instance"

  BOOTSTRAP=${BOOTSTRAP:-/opt/opendj/bootstrap/setup.sh}

  echo "Running $BOOTSTRAP"
  $BOOTSTRAP

fi

# Check if keystores are mounted as a volume, and if so overwrite
# override the generated keystores
SECRET_VOLUME=${SECRET_VOLUME:-/var/secrets/opendj}

if [ -d ${SECRET_VOLUME} ]; then
  echo "Secret volume is present. Will copy keystores and truststore"
  cp -f ${SECRET_VOLUME}/*  ./data/config
fi

# todo: Check /opt/opendj/data/config/buildinfo
# Run upgrade if the server is older


echo "Starting OpenDJ"

# todo: Test to see if it is already running
exec ./bin/start-ds --nodetach