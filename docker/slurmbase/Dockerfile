ARG UBUNTU_BASE_TAG=23.04

FROM ubuntu:${UBUNTU_BASE_TAG}

ARG USERNAME="ikimslurm"
ARG USER_UID=1099
ARG USER_GID=${USER_UID}
ARG SLURM_STATE_SAVE_LOCATION=/var/spool/slurmctld
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
        slurm-wlm-basic-plugins \
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
COPY etc/ssh/sshd_config.d/auth.conf /etc/ssh/sshd_config.d/
RUN mkdir /run/sshd

# Create the Munge socket directory.
RUN mkdir -p /run/munge \
    && chown "munge:munge" /run/munge

# Copy the supervisor definition files.
COPY etc/supervisor/conf.d/sssd.conf \
    etc/supervisor/conf.d/sshd.conf \
    etc/supervisor/conf.d/munged.conf \
    /etc/supervisor/conf.d/

# Copy the entrypoint script.
COPY entrypoint.sh /entrypoint.sh

# Prepare directories for the slurm daemons. Ownership is assigned to the user
# "slurm" created by the slurm-wlm-basic-plugins package.
RUN mkdir -p "$SLURM_STATE_SAVE_LOCATION" "$SLURM_LOG_DIR" "$SLURM_PID_DIR" \
    && chown "slurm:slurm" "$SLURM_STATE_SAVE_LOCATION" "$SLURM_LOG_DIR" "$SLURM_PID_DIR"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--nodaemon"]

VOLUME ["/ipaadmin"]

EXPOSE 22
