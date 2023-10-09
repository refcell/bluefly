
all: up

up:
	vagrant up
.PHONY: up

nuke:
	vagrant destroy --force
.PHONY: nuke

remove:
	vagrant box remove ubuntu/trusty64
.PHONY: remove

ssh:
	vagrant ssh
.PHONY: ssh
