FROM ubuntu:latest
ARG RSA
ARG PUB
RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    sudo \
    make \
    ssh \
    vim \
    jq \
    curl \
    python3.8 python3.8-dev python3-pip \
    build-essential \
    libssl-dev \
    libffi-dev \
    net-tools \
    iputils-ping \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN rm /usr/bin/python3 && ln -s /usr/bin/python3.8 /usr/bin/python3
RUN rm /usr/bin/python||true && ln -s /usr/bin/python3 /usr/bin/python
RUN mkdir /var/run/sshd
RUN mkdir /home/ansible
RUN mkdir -m700 /home/ansible/.ssh
COPY ${RSA} /home/ansible/.ssh/id_rsa
COPY ${PUB} /home/ansible/.ssh/id_rsa.pub
COPY authorized_keys /home/ansible/.ssh/authorized_keys
RUN groupadd ansible -g 9001
RUN useradd -g ansible -u 9001 ansible -d /home/ansible --shell /bin/bash
RUN echo 'ansible:!ansibl3' | chpasswd
RUN adduser ansible sudo
RUN chown -R ansible:ansible /home/ansible
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
RUN sed -i 's/#Listen/Listen/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
ENTRYPOINT service ssh restart && bash && su - ansible

