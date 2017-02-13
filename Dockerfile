FROM ubuntu:16.04

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 72ECF46A56B4AD39C907BBB71646B01B86E50310 \
    && echo "deb http://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
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
        yarn \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && gem install scss_lint \
    && ln -s /usr/bin/nodejs /usr/bin/node \
    && npm install --global npm \
    && npm config set progress false

# This is used by bower to disable interactive mode
ENV CI true

## Install base node modules
RUN yarn global add \
    grunt-cli \
    bower \
    less \
    recess \
    bless@3.0.3 \
    gulp-cli \
    phantomjs-prebuilt

COPY run.sh /run.sh

VOLUME ["/tuleap"]
VOLUME ["/srpms"]

ENTRYPOINT ["/run.sh"]
