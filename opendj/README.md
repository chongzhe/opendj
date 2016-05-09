# ForgeRock OpenDJ Docker image

Listens on 389/636/4444/8989

Default bind credentials are CN=Directory Manager, password is 'password'
(but you should change this, see below)

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


# Passwords

The Dockerfile expects a password file to be mounted at 
the path pointed to by the env var DIR_MANAGER_PW_FILE.
The default path is /var/secrets/dirmanager.pw, and the default
value is "password".

Typically you will mount a Docker volume or Kubernetes 
secret volume on this path to securely provide the password.

This should only be needed at setup time as the directory will
start without the password. However, utilities that you 
might want to run in the container may want the password.
