ARG UBUNTU_BASE_TAG=22.04

FROM ubuntu:${UBUNTU_BASE_TAG}

ARG USERNAME="ikimslurm"
ARG USER_UID=1000
ARG USER_GID=${USER_UID}
ARG SLURM_STATE_SAVE_LOCATION=/var/spool/slurm
ARG SLURM_LOG_DIR=/var/log/slurm
ARG SLURM_PID_DIR=/run/slurm

ENV TZ=Etc/UTC

# Install packages.
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get -y install --no-install-recommends \
        freeipa-client \
        munge \
        openssh-server \
        slurmctld \
        slurmdbd \
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

# Prepare directories for the slurm daemons.
# Ownership is assigned to the user "slurm" created by the Ubuntu package.
RUN mkdir -p "$SLURM_STATE_SAVE_LOCATION" "$SLURM_LOG_DIR" "$SLURM_PID_DIR" \
    && chown "slurm:slurm" "$SLURM_STATE_SAVE_LOCATION" "$SLURM_LOG_DIR" "$SLURM_PID_DIR"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--nodaemon"]

VOLUME ["/ipaadmin"]

# ssh port
EXPOSE 22

# slurmctld port
EXPOSE 6817

# slurmdbd port
EXPOSE 6819
