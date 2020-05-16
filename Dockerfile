FROM openresty/openresty:latest-xenial


# Add some stuff via apt-get
# RUN apt-get update \
#     && apt-get install -y --no-install-recommends \
# 	    libssl-dev \
#     && /usr/local/openresty/luajit/bin/luarocks  install lua-reql \
#     && rm -rf /var/lib/apt/lists/*


# Put Consul data on a separate volume to avoid filesystem performance issues
# with Docker image layers. Not necessary on Triton, but...
#VOLUME ["/data"]

#ENTRYPOINT []

RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-nats

CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]

# Use SIGQUIT instead of default SIGTERM to cleanly drain requests
# See https://github.com/openresty/docker-openresty/blob/master/README.md#tips--pitfalls
STOPSIGNAL SIGQUIT