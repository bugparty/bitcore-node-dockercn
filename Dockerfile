From daocloud.io/bowmanhan2/bitcore-node  as builder
From node:4
ADD config/sources.list /etc/apt/sources.list
RUN \
  apt-get update --force-yes -y && \
  apt-get install -y --force-yes libzmq3-dev vim python

WORKDIR /src
COPY --from=builder /usr/local/lib/node_modules  /usr/local/lib/node_modules
COPY --from=builder /usr/local/bin /usr/local/bin 
COPY --from=builder /src /src
ARG TZ
ARG NETWORK

ENV TZ $TZ
ENV NETWORK $NETWORK

EXPOSE 3001
EXPOSE 8333

CMD \
  cp -rf ./config/$NETWORK.json ./bitcore-node.json &&  \
  bitcored