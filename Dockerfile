FROM  buildpack-deps:latest

WORKDIR /tmp

ENV DOCKER_VERSION 1.12.0
RUN curl -sSL -O https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz \
    && tar zxf docker-${DOCKER_VERSION}.tgz -C /tmp \
    && rm docker-${DOCKER_VERSION}.tgz \
    && mv /tmp/docker/* /usr/local/bin

ENV TERRAFORM_VERSION 0.7.7
RUN curl -sSL -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv terraform /usr/local/bin

ENV PACKER_VERSION 0.11.0
RUN curl -sSL -O https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
    && unzip packer_${PACKER_VERSION}_linux_amd64.zip \
    && rm packer_${PACKER_VERSION}_linux_amd64.zip \
    && mv packer /usr/local/bin

ENV K8S_VERSION # for kubectl & kops

RUN curl -sSL https://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/linux/amd64/kubectl >/usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl
RUN curl -sSL https://github.com/kubernetes/kops/releases/download/v${K8S_VERSION}/kops-linux-amd64 >/usr/local/bin/kops \
    && chmod +x /usr/local/bin/kops


RUN apt-get install python python-pip && pip install awscli



