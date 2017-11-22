#!/bin/bash
BASEDIR=nvidia-virtualgl-selenium-node-base
BASEREPO=https://github.com/treyturner/nvidia-virtualgl-selenium-node-base.git
BASEBRANCH=selenium_upgrade

GCDIR=nvidia-virtualgl-selenium-node-chrome
GCREPO=https://github.com/treyturner/nvidia-virtualgl-selenium-node-chrome.git
GCBRANCH=chrome_upgrade

FFDIR=nvidia-virtualgl-selenium-node-firefox
FFREPO=https://github.com/treyturner/nvidia-virtualgl-selenium-node-firefox.git
FFBRANCH=firefox_upgrade

#clone
if [ ! -d $BASEDIR ]
then
    git clone $BASEREPO $BASEDIR
else
    cd $BASEDIR
    git pull $BASEREPO
    cd ..

#clone
if [ ! -d $GCDIR ]
then
    git clone $GCREPO $GCDIR
else
    cd $GCDIR
    git pull $GCREPO
    cd ..

#clone
if [ ! -d $FFDIR ]
then
    git clone $FFREPO $FFDIR
else
    cd $FFDIR
    git pull $FFREPO
    cd ..

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
