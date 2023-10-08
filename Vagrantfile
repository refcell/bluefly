# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

VM_NAME = 'bluefly'
VM_USER = 'vagrant'
MAC_USER = 'andreasbigger'

Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "echo \"Welcome to BlueFly\""

  config.vm.define "lvim" do |lvim|
    lvim.vm.hostname = VM_NAME
    lvim.vm.synced_folder './lvim', '/home/' + VM_USER + '/lvim'
    lvim.vm.synced_folder '.', '/home/' + VM_USER + '', disabled: true
    lvim.vm.provider "docker" do |d|
      d.build_dir = "lvim"
      d.remains_running = true
      d.has_ssh = true
    end
  end

  # # Port forwarding — uncomment this to use NAT instead of DHCP
  # config.vm.network "forwarded_port", guest: 80, host: VM_PORT
end
