#!/bin/bash

set -e

readonly SOURCE_PATH='/tuleap';
readonly WORK_DIR="$(mktemp --directory)";
MAKE_OPTIONS=""
OS_VERSION=rhel6

configure_npm_registry(){
    if [ ! -z "$NPM_REGISTRY" ]; then
        npm config set registry "$NPM_REGISTRY"
    fi
    if [ ! -z "$NPM_USER" -a ! -z "$NPM_PASSWORD" -a ! -z "$NPM_EMAIL" ]; then
      ./npm-login.sh "$NPM_USER" "$NPM_PASSWORD" "$NPM_EMAIL"
    fi
}

function copy_sources_to_workdir() {
    cp -fRL --preserve=mode,timestamps "$SOURCE_PATH/"* "$WORK_DIR"
}

function build_srpms {
    local os_version=$1
    local target=$2

    if make -C "$WORK_DIR/tools/rpm" srpms-docker OS="$os_version" $MAKE_OPTIONS; then
        mkdir -p "/srpms/$os_version"
        mv /root/rpmbuild/SRPMS/* "/srpms/$os_version"
    else
        echo "SRPMs can not be built from $os_version"
    fi
}

options=$(getopt -o h -l git:,os: -- "$@")

eval set -- "$options"
while true
do
    case "$1" in
    --git)
        MAKE_OPTIONS="$MAKE_OPTIONS GIT_BRANCH=$2";
        shift 2;;
    --os)
        OS_VERSION=$2
        shift 2;;
    --)
        shift 1; break ;;
    *)
        break ;;
    esac
done

configure_npm_registry
copy_sources_to_workdir

build_srpms $OS_VERSION
