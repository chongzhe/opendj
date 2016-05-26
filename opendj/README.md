# ForgeRock OpenDJ Docker image

Listens on 389/636/4444/8989

Default bind credentials are CN=Directory Manager, password is 'password'
(but you should change this, see below)

All writable files and configuration (persisted data) are kept under /opt/opendj/data

To run with Docker (example)
```
mkdir dj    # Make an instance dir to persist data
docker run -i -t -v `pwd`/dj:/opt/opendj/data forgerock/opendj:nightly
```

For Kubernetes mount a PV on /opt/opendj/data

If you choose not to mount a persistent volume OpenDJ will start fine - but you will lose your data when the container 
 is removed.


# Bootstrapping the configuration

When the image comes up, it looks for a backend database and configuration
under /opt/opendj/data

If no database exists, the script /opt/opendj/bootstrap/setup.sh will be
 run.  The default script path can be overridden by setting the environment
 variable BOOTSTRAP to the full path to the script.  To customize OpenDJ, 
 mount a volume on /opt/opendj/bootstrap/ that contains your setup.sh
 script. 
 
If you do not provide a bootstrap script, the default setup.sh creates a sample back end.

A couple of examples are provided under the bootstrap directory:

* bootstrap/cts/  - configures DJ for an OpenAM CTS server 
* bootstrap/replica - sets up a master and a replica server. See dj-replica.yml
for an example of how to invoke this with docker compose.


# Passwords

The Dockerfile expects a password file to be mounted at 
the path pointed to by the env var DIR_MANAGER_PW_FILE. This 
file contains the Directory Manager password. 
The default path is /var/secrets/dirmanager.pw, and the default
value is "password".

Typically you will mount a Docker volume or Kubernetes 
secret volume on this path to securely provide the password.

This should only be needed at setup time as the directory will
start without the password. However, utilities that you 
might want to run in the container may require the password.

# Backup  and Restore


See https://forgerock.org/opendj/doc/bootstrap/admin-guide/#chap-backup-restore 

The suggested strategy for Docker is to mount a volume on /opt/opendj/bak, and schedule DJ backups via the DJ cron 
facility. The backup files can then be moved to secondary storage. 

To take an immediate backup,  exec into the Docker image and run the bin/backup command manually.

A copy of the /opt/opendj/data/config/ directory should also be saved as it contains the encryption keys for the server and the backup. If you lose the configuration you will not be able to recover the backup data. 




