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
  config.vm.define "lvim" do |lvim|
    lvim.ssh.username = 'root'
    lvim.ssh.insert_key = 'true'
    lvim.vm.hostname = VM_NAME
    lvim.vm.synced_folder '/Users/' + MAC_USER + '/projects', '/root/projects'
    # lvim.vm.synced_folder LOCAL_HOME, "/root/", type: "rsync",
    #   rsync__args: ["-r", "--include=.zshrc", "--exclude=*"]
    lvim.vm.provision "file", source: "./robbyrussell.zsh-theme", destination: "/root/.oh-my-zsh/custom/"
    lvim.vm.provision "file", source: ".zshrc", destination: "/root/"
    lvim.vm.provision "file", source: LOCAL_HOME + "/.zshenv", destination: "/root/"
    # lvim.vm.synced_folder './lvim', '/root/lvim'
    lvim.vm.provider "docker" do |d|
      d.build_dir = "lvim"
      d.remains_running = true
      d.has_ssh = true
    end
  end
end
