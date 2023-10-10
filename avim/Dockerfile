# Latest Ubuntu
FROM ubuntu:latest

ARG TARGETOS
ARG TARGETARCH

# Update and install required utilities
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends ssh sudo

# Create a vagrant user
RUN useradd --create-home -s /bin/bash vagrant 
RUN echo -n 'vagrant:vagrant' | chpasswd
RUN echo 'vagrant ALL = NOPASSWD: ALL' > /etc/sudoers.d/vagrant
RUN chmod 440 /etc/sudoers.d/vagrant

# SSH Setup
RUN mkdir -p /home/vagrant/.ssh
RUN chmod 700 /home/vagrant/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ==" \
    > /home/vagrant/.ssh/authorized_keys
RUN chmod 600 /home/vagrant/.ssh/authorized_keys
RUN chown -R vagrant:vagrant /home/vagrant/.ssh
RUN sed -i -e 's/Defaults.*requiretty/#&/' /etc/sudoers
RUN sed -i -e 's/\(UsePAM \)yes/\1 no/' /etc/ssh/sshd_config
RUN mkdir /var/run/sshd
RUN apt-get -y install openssh-client
RUN usermod -aG sudo vagrant

RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ==" \
    > /root/.ssh/authorized_keys

# Update system and install core packages/dependencies
RUN apt-get update -y
RUN apt-get install --no-install-recommends -y \
  apt-transport-https autoconf automake \
  btop build-essential \
  ca-certificates cmake coreutils curl

RUN apt-get install --no-install-recommends -y \
  doxygen fd-find fzf \
  g++ gettext git gnupg gh \
  libtool libtool-bin locales

RUN apt-get install --no-install-recommends -y \
  make npm openssl \
  pkg-config python3-pip \
  ripgrep tar unzip wget zip zsh zoxide

# Install an updated neovim
RUN git clone https://github.com/neovim/neovim
RUN cd neovim && make CMAKE_BUILD_TYPE=Release && sudo make install

# Link python and fd
RUN rm -rf /var/lib/apt/lists/*
RUN ln -s "$(which fdfind)" /usr/bin/fd
RUN ln -s "$(which python3)" /usr/bin/python

RUN apt-get update

# Install Rust once curl and build-essential are installed
# Add it to the default $PATH
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install golang
RUN curl -sLo go.tar.gz "https://go.dev/dl/go1.20.linux-${TARGETARCH}.tar.gz"
RUN tar -C /usr/local/bin -xzf go.tar.gz
RUN rm go.tar.gz

# Install OMZ
RUN curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh > ohmyzsh.sh
RUN chmod +x ohmyzsh.sh
RUN yes Y | ./ohmyzsh.sh 

# Make zsh the default shell
RUN chsh -s $(which zsh)

# zsh-autosuggestions install
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# RTX Install
RUN curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh > binstall.sh
RUN chmod +x binstall.sh
RUN ./binstall.sh
RUN cargo install rtx-cli

# Install Astronvim
RUN git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
RUN git clone --depth 1 https://github.com/refcell/bluefly /root/bluefly
RUN cp -r /root/bluefly/avim/nvim ~/.config/

# Install Nerdfonts
RUN git clone https://github.com/ronniedroid/getnf.git
RUN cd getnf && chmod +x ./install.sh && ./install.sh

# Hush Login
RUN touch /root/.hushlogin

# Update the PATH
ENV DEBIAN_FRONTEND=noninteractive
ENV ROOT_PATH=/root
ENV GOPATH=$ROOT_PATH/.local/share/go
ENV LOCAL_BIN=$ROOT_PATH/.local/bin
ENV CARGO_BIN=$ROOT_PATH/.cargo/bin
ENV NPM_BIN=$ROOT_PATH/.npm-global/bin
ENV GO_BIN=$GOPATH/bin
ENV PATH "$PATH:$LOCAL_BIN:$CARGO_BIN:$NPM_BIN:$GO_BIN"
RUN echo "export PATH=${PATH}" >> /root/.profile
RUN echo "export PATH=${PATH}" >> /home/vagrant/.profile

# Update locales
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8

# Expose ssh
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
