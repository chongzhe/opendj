


# Secrets

The derived child image will have secrets (amadmin password, etc.) embedded in the image. Currently, there
is no great solution for securing build time secrets in Docker. 

See https://github.com/docker/docker/issues/13490  for more details. 

You will have to keep the image private, and any configuration files that might be checked into a VCS. 
 
 