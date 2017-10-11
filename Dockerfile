FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y \
        nodejs \
        npm \
        ruby-sass \
        build-essential \
        rpm \
        php \
        libfontconfig \
        git \
        cpio \
        gettext \
        expect \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && gem install scss_lint \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Composer Installer verified'; } else { echo 'Composer Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar //usr/local/bin/composer

# This is used by bower to disable interactive mode
ENV CI true

# Disable cli progress animation in npm
RUN ln -s /usr/bin/nodejs /usr/bin/node \
    && npm install --global npm@5.4.2 grunt-cli gulp-cli bower \
    && npm config set progress false

COPY run.sh /run.sh
COPY npm-login.sh /npm-login.sh

VOLUME ["/tuleap"]
VOLUME ["/srpms"]

ENTRYPOINT ["/run.sh"]
