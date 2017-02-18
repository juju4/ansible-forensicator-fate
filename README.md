[![Build Status - Master](https://travis-ci.org/juju4/ansible-forensicator-fate.svg?branch=master)](https://travis-ci.org/juju4/ansible-forensicator-fate)
[![Build Status - Devel](https://travis-ci.org/juju4/ansible-forensicator-fate.svg?branch=devel)](https://travis-ci.org/juju4/ansible-forensicator-fate/branches)
# Forensicator-fate ansible role

Ansible role to setup forensicator fate with updated environment
Bringing DevOps to Forensics
https://github.com/z3ndrag0n/forensicator-fate/
https://www.sans.org/reading-room/whitepapers/forensics/forensicator-fate-artisan-engineer-35522

Most notably: Jenkins 2.x
Web interface ffate.py is still not fully setup but tasks can be really managed from Jenkins (mostly findWindowsEvidence job)

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.2

### Operating systems

Ubuntu 14.04 (dependencies on SANS SIFT)

## Example Playbook

Just include this role in your list.
For example

```
- host: ffate-elk
  roles:
    - ...

- host: ffate
  roles:
    - juju4.forensicator-fate

```

## Variables

Nothing specific for now.

## Continuous integration

This role has a travis basic test (for github), more advanced with kitchen and also a Vagrantfile (test/vagrant).
Default kitchen config (.kitchen.yml) is lxd-based, while (.kitchen.vagrant.yml) is vagrant/virtualbox based.

Once you ensured all necessary roles are present, You can test with:
```
$ gem install kitchen-ansible kitchen-lxd_cli kitchen-sync kitchen-vagrant
$ cd /path/to/roles/juju4.forensicator-fate
$ kitchen verify
$ kitchen login
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```
or
```
$ cd /path/to/roles/juju4.forensicator-fate/test/vagrant
$ vagrant up
$ vagrant ssh
```

Role has also a packer config which allows to create image for virtualbox, vmware, eventually digitalocean, lxc and others.
When building it, it's advise to do it outside of roles directory as all the directory is upload to the box during building 
and it's currently not possible to exclude packer directory from it (https://github.com/mitchellh/packer/issues/1811)
```
$ cd /path/to/packer-build
$ cp -Rd /path/to/juju4.forensicator-fate/packer .
## update packer-*.json with your current absolute ansible role path for the main role
## you can add additional role dependencies inside setup-roles.sh
$ cd packer
$ packer build packer-*.json
$ packer build -only=virtualbox-iso packer-*.json
## if you want to enable extra log
$ PACKER_LOG_PATH="packerlog.txt" PACKER_LOG=1 packer build packer-*.json
## for digitalocean build, you need to export TOKEN in environment.
##  update json config on your setup and region.
$ export DO_TOKEN=xxx
$ packer build -only=digitalocean packer-*.json
```

## Troubleshooting & Known issues

* If you want to clear all jobs and artefacts from your instance
```
rm -R /var/lib/jenkins/jobs/*/builds/* /artefacts/*
```

* SIFT and ELK require a lot of memory. 8GB+ recommended. 4GB minimum.


## License

BSD 2-clause

