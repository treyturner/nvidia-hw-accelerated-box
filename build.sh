#!/bin/bash
BASEDIR=nvidia-virtualgl-selenium-node-base
BASEREPO=https://github.com/treyturner/nvidia-virtualgl-selenium-node-base.git
BASEBRANCH=master

GCDIR=nvidia-virtualgl-selenium-node-chrome
GCREPO=https://github.com/treyturner/nvidia-virtualgl-selenium-node-chrome.git
GCBRANCH=master

FFDIR=nvidia-virtualgl-selenium-node-firefox
FFREPO=https://github.com/treyturner/nvidia-virtualgl-selenium-node-firefox.git
FFBRANCH=master

#clone
if [ ! -d $BASEDIR ]; then
    git clone $BASEREPO $BASEDIR
else
    cd $BASEDIR
    git pull $BASEREPO
    cd ..
fi

#clone
if [ ! -d $GCDIR ]; then
    git clone $GCREPO $GCDIR
else
    cd $GCDIR
    git pull $GCREPO
    cd ..
fi

#clone
if [ ! -d $FFDIR ]; then
    git clone $FFREPO $FFDIR
else
    cd $FFDIR
    git pull $FFREPO
    cd ..
fi

#switch branches and build
cd $BASEDIR
git checkout $BASEBRANCH
docker build -t treyturner/$BASEDIR .
cd ../$GCDIR
git checkout $GCBRANCH
docker build -t treyturner/$GCDIR .
cd ../$FFDIR
git checkout $FFBRANCH
docker build -t treyturner/$FFDIR .
cd ..
