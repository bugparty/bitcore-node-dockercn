FROM node:4

ADD config/sources.list /etc/apt/sources.list
RUN \
  apt-get update --force-yes -y && \
  apt-get install -y --force-yes libzmq3-dev build-essential vim python

RUN npm config set registry https://registry.npm.taobao.org
# ENV http_proxy http://192.168.2.22:8118
# ENV npm_config_proxy=http://192.168.2.22:8118
RUN \
   npm -g install bitcore@4.1.0

COPY . /src

WORKDIR /src

RUN \
  npm install

ARG TZ
ARG NETWORK

ENV TZ $TZ
ENV NETWORK $NETWORK

EXPOSE 3001
EXPOSE 8333

CMD \
  cp -rf ./config/$NETWORK.json ./bitcore-node.json &&  \
  bitcored
