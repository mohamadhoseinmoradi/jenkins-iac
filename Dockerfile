FROM jenkins/jenkins:lts
USER root

RUN apt update && \
    apt install -y apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common

# install docker cli
RUN \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt update && apt install -y docker-ce-cli

# install kubectl
RUN curl -LO \
    "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin

# install helm
RUN curl https://baltocdn.com/helm/signing.asc | apt-key add - \
    && echo "deb https://baltocdn.com/helm/stable/debian/ all main" \
    | tee /etc/apt/sources.list.d/helm-stable-debian.list \
    && apt update && apt install -y helm

# install ansible 
RUN add-apt-repository \ 
    "deb http://ppa.launchpad.net/ansible/ansible/ubuntu focal main" \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 \
    && apt update && apt install -y ansible

USER jenkins