#!/bin/bash

#set -e

readonly BASE_PATH="/tuleap";
MAKE_OPTIONS=""

function cleanup {
    local base_path_owner
    base_path_owner="$(stat -c '%u:%g' "$BASE_PATH")"
    chown -R "$base_path_owner" "$BASE_PATH"
}
trap cleanup EXIT

configure_npm_registry(){
    if [ ! -z "$NPM_REGISTRY" ]; then
        npm config set registry "$NPM_REGISTRY"
    fi
    if [ ! -z "$NPM_USER" -a ! -z "$NPM_PASSWORD" -a ! -z "$NPM_EMAIL" ]; then
      ./npm-login.sh "$NPM_USER" "$NPM_PASSWORD" "$NPM_EMAIL"
    fi
}

function build_srpms {
    local os_version=$1

    if make -C $BASE_PATH/tools/rpm srpms-docker OS="$os_version" $MAKE_OPTIONS; then
        mkdir -p "/srpms/$os_version"
        mv /root/rpmbuild/SRPMS/* "/srpms/$os_version"
    else
        echo "SRPMs can not be built from $os_version"
    fi
}

options=$(getopt -o h -l git: -- "$@")

eval set -- "$options"
while true
do
    case "$1" in
    --git)
        MAKE_OPTIONS="$MAKE_OPTIONS GIT_BRANCH=$2";
        shift 2;;
    --)
        shift 1; break ;;
    *)
        break ;;
    esac
done

configure_npm_registry

build_srpms 'rhel6'
