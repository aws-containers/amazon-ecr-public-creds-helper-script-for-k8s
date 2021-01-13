# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

ARG  AWS_CLI_VERSION=2.1.12

FROM amazon/aws-cli:${AWS_CLI_VERSION}

RUN  yum update -y \
       && yum install -y openssl \
       && yum clean all

# See https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html for other kubectl versions or AWS China regions
ARG  KUBECTL_DOWNLOAD_URL=https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/kubectl
ARG  KUBECTL_SHA256_URL=https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/kubectl.sha256

RUN  curl -o kubectl ${KUBECTL_DOWNLOAD_URL} \
       && curl -o kubectl.sha256 ${KUBECTL_SHA256_URL} \
       && openssl sha1 -sha256 kubectl \
       && chmod +x ./kubectl \
       && mv ./kubectl /usr/local/bin/kubectl

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
