# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

VM_NAME = 'bluefly'
VM_USER = 'vagrant'

MAC_USER = ENV['LOCAL_USER']

Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "echo \"Welcome to BlueFly\""

  config.vm.define "lvim" do |lvim|
    lvim.ssh.username = 'root'
    lvim.ssh.insert_key = 'true'
    lvim.vm.hostname = VM_NAME
    lvim.vm.synced_folder './lvim', '/home/' + VM_USER + '/lvim'
    lvim.vm.synced_folder './lvim', '/root/lvim'
    lvim.vm.synced_folder '.', '/home/' + VM_USER + '', disabled: true
    lvim.vm.provider "docker" do |d|
      d.build_dir = "lvim"
      d.remains_running = true
      d.has_ssh = true
    end
  end
end
