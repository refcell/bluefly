
avim: avim-up avim-ssh

lvim: lvim-up lvim-ssh

all: lvim-up avim-up

lvim-up:
	vagrant up lvim
.PHONY: lvim-up

avim-up:
	vagrant up avim
.PHONY: avim-up

nuke:
	vagrant destroy --force
.PHONY: nuke

remove:
	vagrant box remove ubuntu/trusty64
.PHONY: remove

lvim-ssh:
	vagrant ssh lvim
.PHONY: lvim-ssh

avim-ssh:
	vagrant ssh avim
.PHONY: avim-ssh
