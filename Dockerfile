FROM amazonlinux

##
##
RUN set -eu \
  && curl --silent --location https://rpm.nodesource.com/setup_12.x | bash - \
  && yum install -y \
    awscli \
    nodejs \
    git \
    make \
    tar \
  && npm install -g \
    typescript \
    ts-node \
    aws-cdk \
  && yum clean all \
  && curl https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz | tar -C /usr/local -xz

ENV PATH  $PATH:/usr/local/go/bin
