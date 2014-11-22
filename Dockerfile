FROM ubuntu:14.04

MAINTAINER Martin GOYOT <martin.goyot@enalean.com>

ADD run.sh /run.sh

## Install dependancies
## Install base node modules
RUN apt-get update && \
    apt-get install -y \
    nodejs \
    npm \
    build-essential \
    rpm \
    libfontconfig \
    git ; \
    ln -s /usr/bin/nodejs /usr/bin/node ; \
    npm install -g \
    grunt-cli \
    bower \
    less \
    recess ; \
    chmod u+x /run.sh

VOLUME ["/tuleap"]
VOLUME ["/srpms"]

#ENTRYPOINT ["/run.sh"]
