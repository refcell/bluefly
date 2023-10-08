# Latest Ubuntu
FROM ubuntu:latest

ARG TARGETOS
ARG TARGETARCH

# Update and install required utilities
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends ssh sudo

# Update system and install core packages/dependencies
RUN apt-get update -y
RUN apt-get install --no-install-recommends -y \
  apt-transport-https autoconf automake \
  btop build-essential \
  ca-certificates cmake coreutils curl

RUN apt-get install --no-install-recommends -y \
  doxygen fd-find fzf \
  g++ gettext git gnupg \
  libtool libtool-bin locales

RUN apt-get install --no-install-recommends -y \
  make npm openssl \
  pkg-config python3-pip \
  ripgrep tar unzip wget zip

# Link python and fd
RUN rm -rf /var/lib/apt/lists/* \
  && ln -s "$(which fdfind)" /usr/bin/fd \
  && ln -s "$(which python3)" /usr/bin/python

# Install Rust once curl and build-essential are installed
# Add it to the default $PATH
RUN apt-get update
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install neovim
RUN cargo install bob-nvim
RUN bob install stable
RUN bob use stable

# Install golang
RUN curl -sLo go.tar.gz "https://go.dev/dl/go1.20.linux-${TARGETARCH}.tar.gz" \
  && tar -C /usr/local/bin -xzf go.tar.gz \
  && rm go.tar.gz

# Install Lunarvim
# RUN curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh > install.sh
# RUN chmod +x install.sh
# RUN LV_BRANCH='release-1.3/neovim-0.9' ./install.sh --yes

# Create the user
RUN useradd --create-home -s /bin/bash vagrant 
RUN echo -n 'vagrant:vagrant' | chpasswd
RUN echo 'vagrant ALL = NOPASSWD: ALL' > /etc/sudoers.d/vagrant
RUN chmod 440 /etc/sudoers.d/vagrant

# SSH Setup
RUN mkdir -p /home/vagrant/.ssh
RUN chmod 700 /home/vagrant/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ==" > /home/vagrant/.ssh/authorized_keys
RUN chmod 600 /home/vagrant/.ssh/authorized_keys
RUN chown -R vagrant:vagrant /home/vagrant/.ssh
RUN sed -i -e 's/Defaults.*requiretty/#&/' /etc/sudoers
RUN sed -i -e 's/\(UsePAM \)yes/\1 no/' /etc/ssh/sshd_config
RUN mkdir /var/run/sshd
RUN apt-get -y install openssh-client

# Update the PATH
ENV DEBIAN_FRONTEND=noninteractive
ENV ROOT_PATH=/root
ENV GOPATH=$ROOT_PATH/.local/share/go
ENV BOB_NVIM_BIN=$ROOT_PATH/.local/share/bob/nvim-bin
ENV LOCAL_BIN=$ROOT_PATH/.local/bin
ENV CARGO_BIN=$ROOT_PATH/.cargo/bin
ENV NPM_BIN=$ROOT_PATH/.npm-global/bin
ENV GO_BIN=$GOPATH/bin
ENV PATH "$PATH:$LOCAL_BIN:$CARGO_BIN:$NPM_BIN:$GO_BIN:$BOB_NVIM_BIN"
RUN echo "export PATH=/new/path:${PATH}" >> /root/.bashrc
RUN echo "export PATH=/new/path:${PATH}" >> /home/vagrant/.bashrc

# Expose ssh
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
