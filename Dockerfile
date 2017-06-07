FROM ubuntu:16.04

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
        expect \
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
## The crappy stuff for PhantomJS is here because since npm 5 phantomjs-prebuilt
## can not be installed globally (see https://github.com/Medium/phantomjs/issues/707)
RUN npm install --global \
    grunt-cli \
    bower \
    less \
    recess \
    bless@3.0.3 \
    gulp-cli && \
    npm install --no-save phantomjs-prebuilt && \
    mv /node_modules/phantomjs-prebuilt /usr/local/lib/node_modules/phantomjs-prebuilt && \
    ln -s /usr/local/lib/node_modules/phantomjs-prebuilt/bin/phantomjs /usr/local/bin/phantomjs

COPY run.sh /run.sh
COPY npm-login.sh /npm-login.sh

VOLUME ["/tuleap"]
VOLUME ["/srpms"]

ENTRYPOINT ["/run.sh"]
