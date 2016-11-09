FROM  buildpack-deps:latest

RUN apt-get update && apt-get install unzip

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

ENV K8S_VERSION 1.4.1

RUN curl -sSL -O https://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/linux/amd64/kubectl \
    && mv kubectl /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl
RUN curl -sSL -O https://github.com/kubernetes/kops/releases/download/v${K8S_VERSION}/kops-linux-amd64 \
    && mv kops-linux-amd64 /usr/local/bin/kops \
    && chmod +x /usr/local/bin/kops


RUN curl -sSL -O https://s3.amazonaws.com/aws-cli/awscli-bundle.zip \
    && unzip awscli-bundle.zip \
    && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws \
    && rm awscli-bundle.zip \
    && rm -rf awscli-bundle



