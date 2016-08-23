# OpenAM Sample(s)


docker-compose.yaml - creates simple OpenAM install with embedded
OpenDJ

Run with:

```
docker-compose up  
```



dj-ext.yaml - Creates OpenAM instance, and an external OpenDJ config store. 

To run:
```
docker-compose -f dj-ext.yaml up
```



Put your docker machine IP in /etc/hosts

127.0.0.1 openam.test.com 

Open http://openam.test.com:8080/openam in your browser


See the comments in the docker compose files for more information

