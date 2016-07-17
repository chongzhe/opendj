# Openam Dockerfile 


This is designed to be a flexible OpenAM image that can be used in 
different deployment styles.

* Running the image directly will result in OpenAM coming up
ready to be configured
* Create a child image (FROM forgerock/openam), and supply a /var/tmp/config directory
to provide bootstrap configuration. See sample/config for the
format
* Alternatively, instead of creating a child image, mount config
files on /var/tmp/config 


# Volumes 

You can mount optional volumes to control the behaviour of the image:

* /root/openam: Mount a volume to persist the bootstrap configuration.
If the container is restarted it will retain it bootstrap config.
* /var/secrets/openam/amadmin.pw:  The configuration script can obtain
the amadmin password from this file 
* /var/secrets/oendj/dirmanager.pw:  The configuration script can obtain
the directory manager bootstrap password from this file. This
would be used if you are using an external OpenDJ config store
* /var/secrets/openam/{key*, .keypass, .storepass}  - optional key
material copied into the /root/openam/openam directory. If you
want all OpenAM instances to have the same keystores you
could mount a Kubernetes secret volume with these files.

See the sample directory for an example of how this works
 
# Building and Boostrapping process

See the Dockerfile and the "run" script to understand how this image boots. The 
short version is:

* The Dockerfile downloads the OpenAM war file and puts it in tomcat/webapps
* The run script checks if the image is already configured 
   (bootstrap exists), and if so, just starts OpenAM
* If no bootstrap exists, it checks for configuration info mounted
on /var/tmp/config. See the sample/ for the format 
* If config info is found, OpenAM is started and configured 
* If no bootstrap is present, and no config info is found, OpenAM
is started. It will be ready to be configured via the web GUI



