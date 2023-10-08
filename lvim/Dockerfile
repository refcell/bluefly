FROM ubuntu

# Setup the VM timezone
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update and install required utilities
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends ssh sudo

# Install some nice to have utilities
RUN apt-get install -y neovim \
    btop \
    nodejs \
    build-essential \
    curl

# Install Rust once curl and build-essential are installed
# Add it to the default $PATH
RUN apt-get update
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Create the bluefly user
RUN useradd --create-home -s /bin/bash bluefly 
RUN echo -n 'bluefly:bluefly' | chpasswd
RUN echo 'bluefly ALL = NOPASSWD: ALL' > /etc/sudoers.d/bluefly
RUN chmod 440 /etc/sudoers.d/bluefly

# SSH Setup
RUN mkdir -p /home/bluefly/.ssh
RUN chmod 700 /home/bluefly/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ==" > /home/vagrant/.ssh/authorized_keys
RUN chmod 600 /home/bluefly/.ssh/authorized_keys
RUN chown -R bluefly:bluefly /home/bluefly/.ssh
RUN sed -i -e 's/Defaults.*requiretty/#&/' /etc/sudoers
RUN sed -i -e 's/\(UsePAM \)yes/\1 no/' /etc/ssh/sshd_config
RUN mkdir /var/run/sshd
RUN apt-get -y install openssh-client

# Expose ssh
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
