# -*- mode: ruby -*-

NAME = 'grundstein'

DEPS = <<SCRIPT
dnf -y install git vim-enhanced
dnf -y install ruby ruby-devel rubygem-bundler
SCRIPT

BUNDLE = <<SCRIPT
pushd /vagrant
bundle install
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.hostname = NAME
  
  config.vm.box = "fedora/23-cloud-base" # see below for virtual box
  config.vm.provision :shell, inline: DEPS
  config.vm.provision :shell, inline: BUNDLE, privileged: false
  
  config.vm.provider "virtualbox" do |vb, override|
    override.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    vb.name = NAME
    vb.memory = 2048
    vb.cpus = 2
  end
end
