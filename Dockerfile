FROM --platform=linux/amd64 rockylinux:9

# Perform update and install the GitHub repository for the GitHub CLI tool.
RUN dnf -y update && \
    dnf -y install 'dnf-command(config-manager)' && \
    dnf -y config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo

# Perform all of the development related group installs from Enterprise Linux 9.
RUN dnf -y groupinstall "Console Internet Tools" && \
    dnf -y groupinstall "Container Management" && \
    dnf -y groupinstall "Development Tools" && \
    dnf -y groupinstall "RPM Development Tools"

# Install some quality of life tools to enhance the container.
RUN dnf -y install \
    curl \
    gh \
    osbuild-ostree \
    ostree \
    ostree-grub2 \
    python-pip \
    python-devel \
    rpm-ostree \
    vim \
    wget

# Install the AWS CLI for S3 access and management.
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
    cd /tmp && unzip awscliv2.zip && \
    ./aws/install && \
    rm -Rf /tmp/awscliv2.zip /tmp/aws