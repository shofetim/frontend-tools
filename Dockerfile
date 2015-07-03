FROM ubuntu:15.04

MAINTAINER Jordan Schatz "jordan@noionlabs.com"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

RUN apt-get install -y curl git make nodejs npm ruby ruby-dev && \
    gem install compass

# Update npm
RUN npm update -g npm

# http://gruntjs.com/getting-started
RUN npm install -g grunt-cli

# http://bower.io/
RUN npm install -g bower

# Bower doesn't know where to find node...
# https://github.com/joyent/node/issues/3911
RUN ln -s /usr/bin/nodejs /usr/bin/node

WORKDIR /app
RUN echo '{"analytics": false}' >~/.bowerrc

# Downgrade sass as there is a bug in the current version
RUN gem uninstall -I sass && gem install sass -v 3.4.11

EXPOSE 9000

CMD grunt serve
