# ForgeRock OpenDJ Docker image

Listens on 389/636/4444

Default bind credentials are CN=Directory Manager, password is 'password'

(TODO: set password from a secret volume)


All writable files and configuration (persisted data) are under /opt/opendj/data

To run with Docker (example)
```
mkdir dj    # Make an instance dir to persist data
docker run -i -t -v `pwd`/dj:/opt/opendj/data forgerock/opendj:nightly
```

For Kubernetes mount a PV on /opt/opendj/data

If you choose not to mount a persistent volume OpenDJ will start OK - but you will lose your data when the container (and assoicated volume) is removed.



# Bootstrapping the configuration

When the image comes up, it looks for a backend database and config
under /opt/opendj/data

If no database exists, it looks under /opt/opendj/boosttrap and runs
setup.sh

The default setup.sh creates a sampple back end. For a more complex
configuration, mount your own custom setup.sh on bootstrap.

An example is provided in the cts/ directory along with a sample
docker-compose file. This example create a fairly complex backend
and sets custom java properties. 



# TODO:
Get password from mounted secret volume


    
  