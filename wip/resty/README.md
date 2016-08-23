# Resty 

Dockerfile to build OpenResty, Luarocks and some handy LUA utility packages

This will install the Ping OIDC module as well in resty.oidc

The samples in config/* show an example of how to configure OIDC


# Notes:

The image design was based on: https://github.com/ficusio/openresty
 
I made several changes:
* Used Ubuntu as the base. I found Alpine had some strange 
behavior, and I never tracked it fully down 
* Added Luarocks. OIDC
* Created an extension strategy


# Customizing 

The run.sh script looks for an environment variable CUSTOM_CONF_DIR. If this
directory exits, the contents are recursively copied to /opt/openresty. 

This allows you to change the configuration at runtime by mounting a volume
and setting this variable to the volume directory. 

The CUSTOM_CONF_DIR should have a structure that mirrors /opt/openresty:
```
$ ls /opt/openresty
bin/  luajit/  lualib/  nginx/  
```


The files in CUSTOM_CONF_DIR will overwrite any files with the same name. 

As an example, your CUSTOM_CONF_DIR might contain something like:
./nginx/conf/nginx.conf
./lualib/my-cool-lib.lua

See the docker-compose.yaml for an example

