Dockerfile to build OpenResty, Luarocks and some handy LUA utility packages

This will install the Ping OIDC module as well

The sample nginx/nginx.conf shows an example of how to use it with
Google as the OIDC Provider. 


Notes:

The image is based on this: https://github.com/ficusio/openresty
 
I made several changes:
- used Ubuntu as the base. I found Alpine had some strange 
behavior, and I never tracked it fully down 
- Added Luarocks 


TODO: Document how to extend this, add custom lua files, etc.

