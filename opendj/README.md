# ForgeRock OpenDJ Docker image

Listens on 389/636/4444/8989

Default bind credentials are CN=Directory Manager, the password defaults to "password"
if you run this as-is, or 'changeme' if you use the docker-compose example. 


Docker compose is the easiest way to experiment with this image. To run with docker-compose

```
docker-compose build
docker-compose up 
```

To run with Docker (example)
```
mkdir dj    # Make an instance dir to persist data
docker run -i -t -v `pwd`/dj:/opt/opendj/data forgerock/opend
```

# Container Strategy 

This image separates out the read only bits (DJ binaries) from the volatile data.

All writable files and configuration (persisted data) are kept under /opt/opendj/data. The idea is that you will mount 
a volume (Docker Volume, or Kubernetes Volume) on /opt/opendj/data that will survive container restarts.

If you choose not to mount a persistent volume OpenDJ will start fine - but you will lose your data when the container 
 is removed.
 
# Secrets
 
For "secrets" such as the Directory Manager password, and for key and trust stores, you 
can mount a secret volume on /var/secrets/opendj. If you do not do this a default password
will be used, and new key and trust stores will be generated. 

As is, the sample setup.sh script looks for a password in /var/secrets/opendj/dirmanager.pw. If this file does
not exist it will use "password". 

The provided docker-compose file demonstrates how to mount a secret volume for passwords and key stores. It
sets the Directory Manager password to "cangetin". 

Note that the ads-truststore used for replication can not be mounted as a secret volume - as OpenDJ
needs to update this file at runtime. Make sure you do not have this keystore in your secret volume.


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
* bootstrap/replica - sets up a master and a replica server. See the dj-replica.yml
docker compose file for an example of how run two masters.


# Backup  and Restore


See https://forgerock.org/opendj/doc/bootstrap/admin-guide/#chap-backup-restore 

The suggested strategy for Docker is to mount a volume on /opt/opendj/bak, and schedule DJ backups via the DJ cron 
facility. The backup files can then be moved to secondary storage. 

To take an immediate backup,  exec into the Docker image and run the bin/backup command manually.

A copy of the /opt/opendj/data/config/ directory should also be saved as it contains the encryption keys for the server and the backup. If you lose the configuration you will not be able to recover the backup data. 


