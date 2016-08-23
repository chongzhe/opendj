# Install Openresty, luarocks, and some handy packages
FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl perl make build-essential procps unzip \
    libreadline-dev libncurses5-dev libpcre3-dev libssl-dev ca-certificates \
 && rm -rf /var/lib/apt/lists/*

ENV OPENRESTY_VERSION 1.9.7.4
ENV OPENRESTY_PREFIX /opt/openresty
ENV NGINX_PREFIX /opt/openresty/nginx
ENV VAR_PREFIX /var/nginx

# NginX prefix is automatically set by OpenResty to $OPENRESTY_PREFIX/nginx
# look for $ngx_prefix in https://github.com/openresty/ngx_openresty/blob/master/util/configure

# Options I removed:
# && readonly NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
# && echo "using upto $NPROC threads" \

RUN cd /root \
 && curl -sSL http://openresty.org/download/openresty-${OPENRESTY_VERSION}.tar.gz | tar -xvz \
 && cd openresty-* \
 && ./configure \
    --prefix=$OPENRESTY_PREFIX \
    --http-client-body-temp-path=$VAR_PREFIX/client_body_temp \
    --http-proxy-temp-path=$VAR_PREFIX/proxy_temp \
    --http-log-path=$VAR_PREFIX/access.log \
    --error-log-path=$VAR_PREFIX/error.log \
    --pid-path=$VAR_PREFIX/nginx.pid \
    --lock-path=$VAR_PREFIX/nginx.lock \
    --with-luajit \
    --with-pcre-jit \
    --with-http_ssl_module \
    --without-http_ssi_module \
    --without-http_userid_module \
    --without-http_uwsgi_module \
    --without-http_scgi_module \
    --with-ipv6 \
 && make \
 && make install \
 && ln -sf $NGINX_PREFIX/sbin/nginx /usr/local/bin/nginx \
 && ln -sf $NGINX_PREFIX/sbin/nginx /usr/local/bin/openresty \
 && ln -sf $OPENRESTY_PREFIX/bin/resty /usr/local/bin/resty \
 && ln -sf $OPENRESTY_PREFIX/luajit/bin/luajit-* $OPENRESTY_PREFIX/luajit/bin/lua \
 && ln -sf $OPENRESTY_PREFIX/luajit/bin/luajit-* /usr/local/bin/lua \
 && rm -rf /root/ngx_openresty

# Install LUA package manager and some modules
RUN cd /root \
 && ln -sf $OPENRESTY_PREFIX /usr/local/openresty \
 && curl -sSL http://luarocks.org/releases/luarocks-2.3.0.tar.gz | tar -xvz \
 && cd luarocks-2.3.0 \
 && ./configure  --prefix=$OPENRESTY_PREFIX/luajit --with-lua=$OPENRESTY_PREFIX/luajit/ \
                 --lua-suffix=jit-2.1.0-beta1 \
                 --with-lua-include=$OPENRESTY_PREFIX/luajit/include/luajit-2.1 \
 && make install;

# ADD OIDC - not in luarocks yet
ADD "https://raw.githubusercontent.com/pingidentity/lua-resty-openidc/master/lib/resty/openidc.lua" /opt/openresty/lualib/resty/openidc.lua


# Now install some packages
RUN cd /opt/openresty/luajit \
   && ./bin/luarocks install lua-resty-session \
   && ./bin/luarocks install lua-resty-http \
   && ./bin/luarocks install lua-resty-template \
   && ./bin/luarocks install inspect \
   && chmod +r /opt/openresty/lualib/resty/openidc.lua


WORKDIR $NGINX_PREFIX/


ADD run.sh /opt/openresty

CMD ["/opt/openresty/run.sh"]