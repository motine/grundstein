## Vagrant

This project uses [Vagrant](https://www.vagrantup.com/) to ramp up the development environment.
This means, that all dependencies for the project are installed in a virtual machine ([Fedora](https://getfedora.org/) 23).
After a little wait for the initial processing of that virtual machine, you run the project within this machine.

Vagrant helps managing this VM, so we have a replicable environment no matter where. It:

* can start and stop the VM independently of the platform
* provides help to provision (installing dependencies) and destroy the VM
* it mounts/syncs your local development sources with the folder in the VM
* and some more...

### Installation

We need [Vagrant](https://www.vagrantup.com/docs/installation/)] >= 1.7.4. Here how to do it on Fedora or on a Mac:

**On Fedora** we are using libvirt and the [libvirt-plugin](https://github.com/pradels/vagrant-libvirt) with NFS folder sync ([firewall configuration](http://nts.strzibny.name/vagrant-nfs-exports-on-fedora-21/)).
Please run following commands:

```bash
dnf install vagrant libxslt-devel libxml2-devel libvirt libvirt-devel libguestfs-tools-c
vagrant plugin install vagrant-libvirt
# get the firewall tamed
sudo firewall-cmd --permanent --add-service=nfs
sudo firewall-cmd --permanent --add-service=rpc-bind
sudo firewall-cmd --permanent --add-service=mountd
sudo firewall-cmd --reload
# avoid password prompt overtime you breathe
sudo gpasswd -a ${USER} libvirt
newgrp libvirt
```

**On Mac** we are assuming you have [homebrew](http://brew.sh/) and [homebrew cask](http://caskroom.io/) installed.
Since, the official Fedora box does not pack guest additions, we also install the [vbguest plugin](https://github.com/dotless-de/vagrant-vbguest):

```bash
brew cask install vagrant
vagrant plugin install vagrant-vaguest # we need this if we use VirtualBox
```

## Getting started

Now we can actually get started:

```bash
vagrant up # start the development environment (also initializes on the first call)

vagrant ssh # jump into the machine
cd /vagrant # the project folder (automatically mounted from your project's root)

# ... now do your work ...

exit # leave the machine
vagrant halt # stop the machine, go home...
vagrant up # bring the machine back up when dropping in again

# project done; or you screwed something up
vagrant destroy # remove the VM and free up local disk space
```
