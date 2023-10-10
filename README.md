### https://github.com/refcell/bluefly/labels/bluefly • https://github.com/refcell/bluefly/labels/nvim https://github.com/refcell/bluefly/labels/vagrant https://github.com/refcell/bluefly/labels/catppuccin

`bluefly` is a one-shot [Vagrant][vagrant-url] engine for bootstrapping batteries-included development environments.

[vagrant-url]: https://developer.hashicorp.com/vagrant

### Why?

I've nuked my neovim setup so many times without taking proper backups. BlueFly is a naive approach at creating a minimal dependency, one-shot tool for bootstrapping pre-configured development environments.

Ideally, BlueFly could use some sort of checkpointing system to retroactively update the config when changes are made besides using synced files, but this is a future enhancement.

### Getting Set Up

First, install [Docker](https://docs.docker.com/get-docker/).

Then, you'll need to have [Vagrant](https://developer.hashicorp.com/vagrant/docs/installation) installed. If you're on a mac, you can simply run the following using [brew](https://brew.sh/).

```shell
$ brew install hashicorp/tap/hashicorp-vagrant
```

Now, you're ready to clone the BlueFly repository and get started!

### Development

`bluefly` is entirely built and maintained by [@refcell](https://github.com/refcell). Design and architecture decisions are opinionated.

*Bluefly would not be possible without [lunarvim][lvim-url] and [astronvim][astronvim-url] projects.*

[lvim-url]: https://www.lunarvim.org/
[astronvim-url]: https://docs.astronvim.com/
