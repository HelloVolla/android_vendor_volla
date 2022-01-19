#!/bin/bash

set -e

MB=$1

USE_PATCH=0
if [ "$MB" != "--mb" ]; then
    USE_PATCH=1
fi

OLD_WD=`pwd`
LOCALDIR=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`
cd $LOCALDIR

if [ "$USE_PATCH" == "1" ]; then
    for patch in `find . -name *.patch |sort`; do
        cd $OLD_WD/$(dirname $patch)
        patch -p1 < $LOCALDIR/$patch
    done
else
    MBS=$(find . -name *.patch -exec dirname {} \; |sort -u)
    for mb in $MBS; do
        cd $OLD_WD/$mb
        git am $LOCALDIR/$mb/*.patch
    done
fi
