# OpenIDM onbuild Dockerfile

This Docker image is not designed to run directly, but rather is 
designed to serve as the parent of a child image. 

The sample/ directory demonstrates how to build a child image.  An onbuild
trigger in the child copies in any conf/ data/ or script/ directories into /opt/openidm.  
When the child starts up it will use your custom configuration. 


