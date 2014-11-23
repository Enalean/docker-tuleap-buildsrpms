FROM ubuntu:14.04

MAINTAINER Martin GOYOT <martin.goyot@enalean.com>

ADD run.sh /run.sh

## Install dependancies
## Install base node modules
# Add ant & openjdk-7-jdk for openfire
# Add zip and unzip for sabredav
RUN apt-get update && \
    apt-get install -y \
    nodejs \
    npm \
    build-essential \
    rpm \
    libfontconfig \
    git \
    ant openjdk-7-jdk \
    zip unzip \
    ; ln -s /usr/bin/nodejs /usr/bin/node ; \
    npm install -g \
    grunt-cli \
    bower \
    less \
    recess ; \
    chmod u+x /run.sh

VOLUME ["/tuleap"]
VOLUME ["/srpms"]

#ENTRYPOINT ["/run.sh"]
