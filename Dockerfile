FROM ubuntu:16.04

MAINTAINER Thomas Gerbet <thomas.gerbet@enalean.com>

RUN apt-get update && \
    apt-get install -y \
    nodejs \
    npm \
    build-essential \
    rpm \
    libfontconfig \
    git \
    cpio

RUN ln -s /usr/bin/nodejs /usr/bin/node

## Install base node modules
RUN npm install -g \
    grunt-cli \
    bower \
    less \
    recess \
    bless@3.0.3

ADD run.sh /run.sh
RUN chmod u+x /run.sh

VOLUME ["/tuleap"]
VOLUME ["/srpms"]

ENTRYPOINT ["/run.sh"]
