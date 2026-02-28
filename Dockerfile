FROM golang:1.16 AS build

ARG SM_VERSION
ENV DEBIAN_FRONTEND=noninteractive
ENV BUILD_DIR=${GOPATH}/src/github.com/JustaPenguin/assetto-server-manager
ENV BUILD_DEST_DIR=/build
ENV GO111MODULE=on

RUN apt update && apt-get install -y build-essential libssl-dev nodejs curl tofrodos dos2unix zip unzip

RUN apt install npm -y
ADD . ${BUILD_DIR}
WORKDIR ${BUILD_DIR}
RUN rm -rf cmd/server-manager/typescript/node_modules
RUN VERSION=${SM_VERSION} make deploy
RUN mv cmd/server-manager/build /
