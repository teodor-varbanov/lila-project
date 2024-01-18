FROM ubuntu:20.04

RUN apt-get update \
&& apt-get upgrade -y

ARG DEBIAN_FRONTEND=noninteractive

RUN apt install -y git \
&& apt install -y curl \
&& apt install -y wget \
&& apt install -y sudo \
&& apt install -y gnupg

## Installs Java
RUN wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb \
&& sudo apt install ./jdk-21_linux-x64_bin.deb

# Installs CS
COPY cs ./cs
RUN chmod +x cs
RUN /cs setup -y

# Prepares MongoSH install
RUN wget -qO- https://www.mongodb.org/static/pgp/server-7.0.asc | sudo tee /etc/apt/trusted.gpg.d/server-7.0.asc
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Prepares NodeJS install 
RUN sudo mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
RUN sudo apt-get update

#Installs MongoSH, NodeJS and pnpm
RUN apt-get install -y mongodb-mongosh
RUN apt-get install nodejs -y
RUN npm i -g pnpm

COPY lila ./lila

RUN mongosh mongodb://172.17.0.3:27017/lichess < lila/bin/mongodb/indexes.js

WORKDIR /lila

RUN mv /lila/git /lila/.git
RUN /lila/ui/build 

COPY lila-ws ./lila-ws

EXPOSE 9663
EXPOSE 9664

COPY lila-entrypoint.sh /lila/lila-entrypoint.sh

ENTRYPOINT [ "bash", "/lila/lila-entrypoint.sh" ]