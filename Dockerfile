FROM ubuntu:16.04

MAINTAINER Thomas Gerbet <thomas.gerbet@enalean.com>

RUN apt-get update \
    && apt-get install -y \
        nodejs \
        npm \
        ruby-sass \
        build-essential \
        rpm \
        libfontconfig \
        git \
        cpio \
        gettext \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && gem install scss_lint

# This is used by bower to disable interactive mode
ENV CI true

# Disable cli progress animation in npm
RUN ln -s /usr/bin/nodejs /usr/bin/node \
    && npm install --global npm \
    && npm config set progress false

## Install base node modules
RUN npm install --global \
    grunt-cli \
    bower \
    gulp-cli \
    phantomjs-prebuilt

ADD run.sh /run.sh
RUN chmod u+x /run.sh

VOLUME ["/tuleap"]
VOLUME ["/srpms"]

ENTRYPOINT ["/run.sh"]
