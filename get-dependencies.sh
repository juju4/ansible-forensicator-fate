#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

if [ $# != 0 ]; then
rolesdir=$1
else
rolesdir=$(dirname $0)/..
fi

[ ! -d $rolesdir/juju4.redhat_epel ] && git clone https://github.com/juju4/ansible-redhat-epel $rolesdir/juju4.redhat_epel
[ ! -d $rolesdir/juju4.sift ] && git clone https://github.com/juju4/ansible-sift $rolesdir/juju4.sift
[ ! -d $rolesdir/juju4.gift ] && git clone https://github.com/juju4/ansible-gift $rolesdir/juju4.gift
[ ! -d $rolesdir/juju4.volatility ] && git clone https://github.com/juju4/ansible-volatility $rolesdir/juju4.volatility
[ ! -d $rolesdir/juju4.rekall ] && git clone https://github.com/juju4/ansible-rekall $rolesdir/juju4.rekall
[ ! -d $rolesdir/ernestas-poskus.docker ] && git clone https://github.com/ernestas-poskus/ansible-role-docker.git $rolesdir/ernestas-poskus.docker
[ ! -d $rolesdir/juju4.jenkins ] && git clone https://github.com/juju4/ansible-jenkins $rolesdir/juju4.jenkins
[ ! -d $rolesdir/juju4.redhat_epel ] && git clone https://github.com/juju4/ansible-redhat-epel $rolesdir/juju4.redhat_epel
[ ! -d $rolesdir/juju4.harden-nginx ] && git clone https://github.com/juju4/ansible-harden-nginx $rolesdir/juju4.harden-nginx
[ ! -d $rolesdir/geerlingguy.java ] && git clone https://github.com/geerlingguy/ansible-role-java.git $rolesdir/geerlingguy.java
[ ! -d $rolesdir/kbrebanov.java ] && git clone https://github.com/juju4/ansible-java.git $rolesdir/kbrebanov.java
[ ! -d $rolesdir/geerlingguy.nginx ] && git clone https://github.com/geerlingguy/ansible-role-nginx.git $rolesdir/geerlingguy.nginx
#[ ! -d $rolesdir/geerlingguy.jenkins ] && git clone https://github.com/geerlingguy/ansible-role-jenkins.git $rolesdir/geerlingguy.jenkins
[ ! -d $rolesdir/geerlingguy.jenkins ] && git clone https://github.com/juju4/ansible-role-jenkins.git $rolesdir/geerlingguy.jenkins
[ ! -d $rolesdir/geerlingguy.postgresql ] && git clone https://github.com/geerlingguy/ansible-role-postgresql.git $rolesdir/geerlingguy.postgresql
## to configure ssh auth to jenkins
[ ! -d $rolesdir/cmprescott.xml ] && git clone https://github.com/cmprescott/ansible-xml.git $rolesdir/cmprescott.xml
## getting v5 roles
[ ! -d $rolesdir/geerlingguy.elasticsearch ] && git clone https://github.com/juju4/ansible-role-elasticsearch.git $rolesdir/geerlingguy.elasticsearch
[ ! -d $rolesdir/geerlingguy.logstash ] && git clone https://github.com/juju4/ansible-role-logstash.git $rolesdir/geerlingguy.logstash
[ ! -d $rolesdir/geerlingguy.kibana ] && git clone https://github.com/juju4/ansible-role-kibana.git $rolesdir/geerlingguy.kibana
## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/juju4.forensicatorfate ] && ln -s ansible-forensicator-fate $rolesdir/juju4.forensicatorfate
[ ! -e $rolesdir/juju4.forensicatorfate ] && cp -R $rolesdir/ansible-forensicator-fate $rolesdir/juju4.forensicatorfate

## for travis?
#[ "X$TRAVIS" = "Xtrue" ] && perl -pi -e "s@^  - ernestas-poskus.docker@#  - ernestas-poskus.docker@" ../sift/meta/main.yml

## don't stop build on this script return code
true
