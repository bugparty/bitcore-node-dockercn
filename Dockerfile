FROM node:4

ADD config/sources.list /etc/apt/sources.list
RUN \
  apt-get update --force-yes -y && \
  apt-get install -y --force-yes libzmq3-dev build-essential vim python

RUN \
  npm config set registry https://registry.npm.taobao.org
RUN \
  npm install -g bitcore

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
