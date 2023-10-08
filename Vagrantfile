# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

VM_NAME = 'svim'
VM_USER = 'vagrant'
MAC_USER = 'andreasbigger'
HOST_PATH = '/Users/' + MAC_USER + '/.config/' + VM_NAME
GUEST_PATH = '/home/' + VM_USER + '/' + VM_NAME

# # VM Port use NAT instead of DHCP
# VM_PORT = 8080

Vagrant.configure("2") do |config|
  # config.vm.box = VAGRANT_BOX

  config.vm.hostname = VM_NAME
  config.vm.synced_folder HOST_PATH, GUEST_PATH
  config.vm.synced_folder '.', '/home/'+VM_USER+'', disabled: true
  config.vm.provider "docker" do |d|
    d.build_dir = "."
    d.remains_running = true
    d.has_ssh = true
  end

  # # Port forwarding — uncomment this to use NAT instead of DHCP
  # config.vm.network "forwarded_port", guest: 80, host: VM_PORT
end
