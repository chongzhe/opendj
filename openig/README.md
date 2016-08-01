# Dockerfile for OpenIG

To build

docker build -t forgerock/openig:latest . 


To run:

docker run -p 8080:8080 -it forgerock/openig

To use OpenIG, mount the IG configuration files on /var/openig

See the sample docker-compose.yaml file for an example

