# Openam Dockerfile 


This is designed to be a flexible OpenAM image that can be used in 
different deployment styles.

* Running the image directly will result in OpenAM coming up
ready to be configured
* Create a child image, and supply a /var/tmp/config directory
to provide bootstrap configuration. See sample/config for the the
format
* Alternatively, instead of creating a child image, mount config
files on /var/tmp/config 


# Volumes 

You can mount optional volumes to control the behaviour of the image:

* /root/openam: Mount a volume to persist the bootstrap configuration.
If the container is restarted it will retain it bootstrap config.
* /var/secrets/openam/dirmanager.pw:  The configuration script can obtain
the directory manager bootstrap password from this file 
* /var/secrets/openam/{key*, .keypass, .storepass}  - optional key
material copied into the /root/openam/openam directory. If you
want all OpenAM instancs to have the same keystores.

See the sample directory for an example of how this works
 

