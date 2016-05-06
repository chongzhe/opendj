# ForgeRock OpenDJ Docker image

Listens on 389/636/4444/8989

Default bind credentials are CN=Directory Manager, password is 'password'

(TODO: set password from a secret volume and/or env variable)


All writable files and configuration (persisted data) are under /opt/opendj/data

To run with Docker (example)
```
mkdir dj    # Make an instance dir to persist data
docker run -i -t -v `pwd`/dj:/opt/opendj/data forgerock/opendj:nightly
```

For Kubernetes mount a PV on /opt/opendj/data

If you choose not to mount a persistent volume OpenDJ will start OK - but you will lose your data when the container (and assoicated volume) is removed.


# Bootstrapping the configuration

When the image comes up, it looks for a backend database and configuration
under /opt/opendj/data

If no database exists, the script /opt/opendj/bootstrap/setup.sh will be
 run.  The default script can be overridden by setting the environment
 variable BOOTSTRAP to point to the script name, and/or by mounting
 a volume on top of /opt/opendj/bootstrap/ that contains a setup.sh
 script. 
 
The default setup.sh creates a sample back end. For a more complex
/configuration, mount your own custom setup.sh on bootstrap.

A couple of examples are provided under the bootstrap directory:

* bootstrap/cts/  - configures DJ for an OpenAM CTS server 
* bootstrap/replica - sets up a master and a replica server. See dj-replica.yml
for an example of how to invoke this with docker compose.


# TODO:
- Get password from mounted secret volume

    
  