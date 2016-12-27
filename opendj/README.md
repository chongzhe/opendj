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
docker run -i -t -v `pwd`/dj:/opt/opendj/data forgerock/opendj
```

# Query OpenDJ Directory

The easist way to query OpenDJ is to use ```ldapsearch``` utility, usually shipped natively with MacOS as well as included in the docker image.

If you run the query from your local mac, you can simply do ```ldapsearch -x``` and you should get results like this:

```
# extended LDIF
#
# LDAPv3
# base <> (default) with scope subtree
# filter: (objectclass=*)
# requesting: ALL
#

# example.com
dn: dc=example,dc=com
objectClass: top
objectClass: domain
dc: example

# People, example.com
dn: ou=People,dc=example,dc=com
objectClass: top
objectClass: organizationalUnit
ou: People

# user.0, People, example.com
dn: uid=user.0,ou=People,dc=example,dc=com
objectClass: top
objectClass: inetOrgPerson
objectClass: organizationalPerson
objectClass: person
mail: user.0@maildomain.net
initials: ASA
homePhone: +1 225 216 5900
pager: +1 779 041 6341
givenName: Aaccf
employeeNumber: 0
telephoneNumber: +1 685 622 6202
mobile: +1 010 154 3228
sn: Amar
cn: Aaccf Amar
description: This is the description for Aaccf Amar.
street: 01251 Chestnut Street
st: DE
postalAddress: Aaccf Amar$01251 Chestnut Street$Panama City, DE  50369
uid: user.0
l: Panama City
postalCode: 50369
```

You can also use the binary within the image by first enter the bash in the image by:
```docker-compose exec opendj /bin/bash```

Then run ```bash /opt/opendj/bin/ldapsearch --hostname localhost --port 389 --baseDN "dc=example,dc=com"   "(objectclass=*)"``` which should return the same results as above

# Work With SSL(ldaps)
You can use SSL-enabled mode with OpenDJ by query the 636 port and with -Z option:
```./ldapsearch -Z --hostname localhost --port 636 --baseDN "dc=example,dc=com"   "(objectclass=*)"```

Since the image use a self-signed CA, the connect could fail because your JVM refuse to recognize the certificate. You will need to either use ```keytool``` to add the certificate to the keystore your JVM uses to add in programatically.

# Container Strategy 

This image separates out the read only bits (DJ binaries) from the volatile data.

All writable files and configuration (persisted data) are kept under /opt/opendj/data. The idea is that you will mount 
a volume (Docker Volume, or Kubernetes Volume) on /opt/opendj/data that will survive container restarts.

If you choose not to mount a persistent volume OpenDJ will start fine - but you will lose your data when the container 
 is removed.
 
# Environment Variable Summary

There are number of environment variables that control the behaviour of the container. These 
will typically be set by docker-compose or Kubernetes

* DIR_MANAGER_PW_FILE: Path to a file that contains the Dir Manager password. This is needed when the image is
first created
* BOOTSTRAP:  Path to a shell script that will initialize OpenDJ. This is only executed if the data/config
directory is empty. Defaults to /opt/opendj/boostrap/setup.sh
* SECRET_VOLUME:  Path to a directory containing keystores. Defaults to /var/secrets/opendj. This is used
to setup OpenDJ with known keystore values.
* BASE_DN: The base DN to create. Used in setup and replication
* DJ_MASTER_SERVER: If set, run.sh will call bootstrap/replicate.sh to enable replication to 
this master. This only happens if the data/config directory does not exist

 
# Secrets
 
For "secrets" such as the Directory Manager password, and for key and trust stores, you 
can mount a secret volume on the path defined by SECRET_VOLUME. If you do not do this a default password
will be used, and new key and trust stores will be generated. 

As is, the sample setup.sh script looks for a password in the patch specified by DIR_MANAGER_PW_FILE. If this file does
not exist it will use "password". 

The provided docker-compose file demonstrates how to mount a secret volume for passwords and key stores. It
sets the Directory Manager password to "cangetin". 

Note that the ads-truststore used for replication can not be mounted as a secret volume - as OpenDJ
needs to update this file at runtime. Make sure you do not have this keystore in your secret volume.


# Bootstrapping the configuration

When the image comes up, it looks for a backend database and configuration
under /opt/opendj/data

If no database exists, the script defined by BOOTSTRAP will be
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

# Replication 

The run.sh will call boostrap/replicate.sh if DJ_MASTER_SERVER is set. The basic idea is that all servers
replicate to a master. This is a very simple strategy that works for very small OpenDJ clusters.

