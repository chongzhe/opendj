# OpenAM onbuild image

This image uses Docker "ONBUILD" directives to run configuration commands in a child image.

*** NOTE ****:  As configured, the image is *not* run designed to run standalone. 
You must create a child image (inherit FROM) and supply the required config/ scripts to 
customize the child image. The e

The child image will be configured using ssoconfig, ssoadm and other scripts. At completion of the child image build, 
the OpenAM instance should be fully configured and ready to run.

See the sample/Dockerfile for an example

# Configuration 

Your child image should have a config/ folder that contains the following:
* env.sh   - Environment vars needed for configuration. Includes the AMADMIN password. 
* openam.properties - Property file for ssoconfig. Note that env var substitution will be run on this file before it is used
* ssoadm.txt  - ssoadm "do_batch" commands should be placed in this file. ssoadm will be run using these commands
* post-config.sh  - (Optional) post configuration script. Any commands you want can be placed in here to complete image

# Secrets

The derived child image will have secrets (amadmin password, etc.) embedded in the image. Currently, there
is no great solution for securing *build time* secrets in Docker. If you are using Kubernetes,
runtime secrets can be protected using secret volumes. 

See https://github.com/docker/docker/issues/13490  for more details. 

You should keep the derived image private - just like you would protect the disk where OpenAM is installed. 
 
 
# Sample 

See the sample/ for an example of how to build and configure a child image.  To build and run:

Put an entry in /etc/hosts for openam.test.com that points to the IP of where docker runs in your 
environment. 

Do the following:

```
docker build -t forgerock/openam-onbuild . 
cd sample
docker-compose build
docker-compose up
```


Open  http://openam.test.com:9080/openam in your browser. Log on with amadmin/password




 