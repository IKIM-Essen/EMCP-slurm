ARG BASE_IMG

FROM ${BASE_IMG}

ARG SLURM_STATE_SAVE_LOCATION=/var/spool/slurm
ARG SLURM_LOG_DIR=/var/log/slurm
ARG SLURM_PID_DIR=/run/slurm

# Install packages.
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get -y install --no-install-recommends slurmctld \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Copy the slurmctld supervisor definition file.
COPY etc/supervisor/conf.d/slurmctld.conf /etc/supervisor/conf.d/

# Prepare directories for slurmctld.
# Ownership is assigned to the user "slurm" created by the Ubuntu package.
RUN mkdir -p "$SLURM_STATE_SAVE_LOCATION" "$SLURM_LOG_DIR" "$SLURM_PID_DIR" \
    && chown "slurm:slurm" "$SLURM_STATE_SAVE_LOCATION" "$SLURM_LOG_DIR" "$SLURM_PID_DIR"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--nodaemon"]

VOLUME ["/ipaadmin"]
EXPOSE 22
EXPOSE 6817
