# Openam Dockerfile


A base image with OpenAM running on tomcat 

Tomcat is listening on 8080 / 8443

Note that we use a custom server.xml that tell tomcat that port 8080 is behind a load balancer that terminates SSL.
This is going to cause issues if this is not the case.  You can either edit the server.xml, or 
use port 8443 which has a self signed cert. 



