
avim: avim-up avim-ssh-export avim-ssh

lvim: lvim-up lvim-ssh

all: lvim-up avim-up

lvim-up:
	vagrant up lvim
.PHONY: lvim-up

avim-up:
	vagrant up avim
.PHONY: avim-up

avim-ssh-export:
	vagrant ssh-config avim > ~/.ssh/avim-vagrant-ssh
.PHONY: avim-ssh-export

avim-target:
	echo "alias avim=\"ssh -F ~/.ssh/avim-vagrant-ssh avim\"" >> ~/.zshrc
.PHONY: avim-target

nuke:
	vagrant destroy --force
	docker system prune --all --force
.PHONY: nuke

remove:
	vagrant box remove ubuntu/trusty64
.PHONY: remove

lvim-ssh:
	vagrant ssh lvim
.PHONY: lvim-ssh

lvim-ssh-export:
	vagrant ssh-config lvim > ~/.ssh/lvim-vagrant-ssh
.PHONY: lvim-ssh-export

lvim-target:
	echo "alias lvim=\"ssh -F ~/.ssh/lvim-vagrant-ssh lvim\"" >> ~/.zshrc
.PHONY: lvim-target


avim-ssh:
	vagrant ssh avim
.PHONY: avim-ssh
