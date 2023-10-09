# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

VM_NAME = 'bluefly'
VM_USER = 'vagrant'
MAC_USER = ENV['LOCAL_USER']

LOCAL_HOME = '/Users/' + MAC_USER

Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "clear"
  config.vm.provision "shell", inline: "echo \"Welcome to BlueFly\""

  # LunarVim
  config.vm.define "lvim" do |lvim|
    lvim.ssh.username = 'root'
    lvim.ssh.insert_key = 'true'
    lvim.vm.hostname = VM_NAME
    lvim.vm.synced_folder '/Users/' + MAC_USER + '/projects', '/root/projects'
    lvim.vm.provision "file", source: "./etc/robbyrussell.zsh-theme", destination: "/root/.oh-my-zsh/custom/"
    lvim.vm.provision "file", source: "./etc/.zshrc", destination: "/root/"
    lvim.vm.provision "file", source: LOCAL_HOME + "/.zshenv", destination: "/root/"
    lvim.vm.provider "docker" do |d|
      d.build_dir = "lvim"
      d.remains_running = true
      d.has_ssh = true
    end
  end

  # Astronvim
  config.vm.define "avim" do |avim|
    avim.ssh.username = 'root'
    avim.ssh.insert_key = 'true'
    avim.vm.hostname = VM_NAME
    avim.vm.synced_folder '/Users/' + MAC_USER + '/projects', '/root/projects'
    avim.vm.provision "file", source: "./etc/robbyrussell.zsh-theme", destination: "/root/.oh-my-zsh/custom/"
    avim.vm.provision "file", source: "./etc/.zshrc", destination: "/root/"
    avim.vm.provision "file", source: LOCAL_HOME + "/.zshenv", destination: "/root/"
    avim.vm.provider "docker" do |d|
      d.build_dir = "avim"
      d.remains_running = true
      d.has_ssh = true
    end
  end
end
