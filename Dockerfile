FROM  buildpack-deps:latest

RUN apt-get update && apt-get -y install unzip python-dev jq

WORKDIR /tmp

ENV DOCKER_VERSION 1.13.0
RUN curl -sSL -O https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz \
    && tar zxf docker-${DOCKER_VERSION}.tgz -C /tmp \
    && rm docker-${DOCKER_VERSION}.tgz \
    && mv /tmp/docker/* /usr/local/bin
    
ENV COMPOSE_VERSION 1.11.2
RUN curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

ENV TERRAFORM_VERSION 0.8.8
RUN curl -sSL -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv terraform /usr/local/bin

ENV PACKER_VERSION 0.12.3
RUN curl -sSL -O https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
    && unzip packer_${PACKER_VERSION}_linux_amd64.zip \
    && rm packer_${PACKER_VERSION}_linux_amd64.zip \
    && mv packer /usr/local/bin

ENV K8S_VERSION 1.5.4

RUN curl -sSL -O https://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/linux/amd64/kubectl \
    && mv kubectl /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

ENV KOPS_VERSION 1.5.3
RUN curl -sSL -O https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64 \
    && mv kops-linux-amd64 /usr/local/bin/kops \
    && chmod +x /usr/local/bin/kops

RUN curl -sSL -O https://s3.amazonaws.com/aws-cli/awscli-bundle.zip \
    && unzip awscli-bundle.zip \
    && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws \
    && rm awscli-bundle.zip \
    && rm -rf awscli-bundle

ENV HELM_VERSION 2.3.0
RUN curl -sSL -O https://kubernetes-helm.storage.googleapis.com/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && tar zxf helm-v${HELM_VERSION}-linux-amd64.tar.gz -C /tmp \
    && rm helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && mv /tmp/linux-amd64/helm /usr/local/bin
