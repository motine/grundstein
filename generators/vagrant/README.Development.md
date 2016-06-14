## Vagrant

This project uses [Vagrant](https://www.vagrantup.com/) to ramp up the development environment.
This means, that all dependencies for the project are installed in a virtual machine (Ubuntu).
After a little wait for the initial processing of that virtual machine, you run the project within this machine.

Vagrant helps managing this VM, so we have a replicable environment no matter where. It:

* can start and stop the VM independently of the platform
* provides help to provision (installing dependencies) and destroy the VM
* it mounts/syncs your local development sources with the folder in the VM
* and some more...

### Installation

We need [Vagrant](https://www.vagrantup.com/docs/installation/)] >= 1.7.4. Please also install the [vbguest plugin](https://github.com/dotless-de/vagrant-vbguest) if you use VirtualBox:

```bash
vagrant plugin install vagrant-vaguest # we may this if we use VirtualBox
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
