#!/bin/bash

mkdir go-cve-dictionary-log goval-dictionary-log gost-log go-exploitdb-log go-msfdb-log

docker run --rm -it \
    -v $PWD:/go-cve-dictionary \
    -v $PWD/go-cve-dictionary-log:/var/log/go-cve-dictionary \
    vuls/go-cve-dictionary fetch nvd
 
docker run --rm -it \
    -v $PWD:/goval-dictionary \
    -v $PWD/goval-dictionary-log:/var/log/goval-dictionary \
    vuls/goval-dictionary fetch redhat 5 6 7 8 9
 
docker run --rm -i \
    -v $PWD:/gost \
    -v $PWD/gost-log:/var/log/gost \
    vuls/gost fetch redhat

docker run --rm -i \
    -v $PWD:/go-exploitdb \
    -v $PWD/go-exploitdb-log:/var/log/go-exploitdb \
    vuls/go-exploitdb fetch exploitdb

docker run --rm -i \
    -v $PWD:/go-exploitdb \
    -v $PWD/go-exploitdb-log:/var/log/go-exploitdb \
    vuls/go-exploitdb fetch awesomepoc

docker run --rm -i \
    -v $PWD:/go-exploitdb \
    -v $PWD/go-exploitdb-log:/var/log/go-exploitdb \
    vuls/go-exploitdb fetch githubrepos

docker run --rm -i \
    -v $PWD:/go-exploitdb \
    -v $PWD/go-exploitdb-log:/var/log/go-exploitdb \
    vuls/go-exploitdb fetch inthewild   

docker run --rm -it \
    -v $PWD:/vuls \
    -v $PWD/vuls-log:/var/log/vuls \
    -v /etc/localtime:/etc/localtime:ro \
    -v /etc/timezone:/etc/timezone:ro \
    vuls/vuls scan 