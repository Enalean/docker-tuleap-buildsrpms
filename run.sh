#!/bin/bash

#set -e

BASE_PATH="/tuleap";
MAKE_OPTIONS=""

options=`getopt -o h -l git: -- "$@"`

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

mkdir -p /srpms/rhel5
mkdir -p /srpms/rhel6

make -C $BASE_PATH/tools/rpm srpms-docker OS="rhel6" $MAKE_OPTIONS
mv /root/rpmbuild/SRPMS/* /srpms/rhel6
make -C $BASE_PATH/tools/rpm srpms-docker OS="rhel5" $MAKE_OPTIONS
mv /root/rpmbuild/SRPMS/* /srpms/rhel5
