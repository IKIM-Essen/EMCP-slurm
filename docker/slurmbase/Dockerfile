ARG UBUNTU_BASE_TAG=22.04

FROM ubuntu:${UBUNTU_BASE_TAG}

ARG USERNAME="ikimslurm"
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

ENV TZ=Etc/UTC

# Install packages.
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get -y install --no-install-recommends \
        freeipa-client \
        munge \
        openssh-server \
        sudo \
        supervisor \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Create a user for logging in via ssh.
RUN groupadd --gid "$USER_GID" "$USERNAME" \
    && useradd -s /bin/bash --uid "$USER_UID" --gid "$USERNAME" -m "$USERNAME"

# Make the ssh user a sudoer.
RUN echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/99-${USERNAME} \
    && chmod 440 /etc/sudoers.d/99-${USERNAME} \
    && visudo -c

# Configure sshd.
COPY etc/ssh/sshd_config.d/*.conf /etc/ssh/sshd_config.d/
RUN mkdir /run/sshd

# Create the Munge socket directory.
RUN mkdir -p /run/munge \
    && chown "munge:munge" /run/munge

# Copy the supervisor definition files.
COPY etc/supervisor/conf.d/*.conf /etc/supervisor/conf.d/

# Copy the entrypoint script.
COPY entrypoint.sh /entrypoint.sh

VOLUME ["/ipaadmin"]
