#!/bin/bash
BASE_PATH="/tuleap";

#mkdir -p /srpms/rhel5
#mkdir -p /srpms/rhel5-st
mkdir -p /srpms/rhel6

make -C $BASE_PATH/tools/rpm srpms-docker OS="rhel6";
mv /root/rpmbuild/SRPMS/* /srpms/rhel6;
#make -C $BASE_PATH/tools/rpm srpms-docker OS="rhel5";
#mv /root/rpmbuild/SRPMS/* /srpms/rhel5;
#make -C $BASE_PATH/tools/rpm srpms-docker OS="rhel5" PKG_NAME="codendi_st";
#mv /root/rpmbuild/SRPMS/* /srpms/rhel5-st;
