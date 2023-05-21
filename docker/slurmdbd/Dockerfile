ARG BASE_IMG

FROM ${BASE_IMG}

ARG SLURM_LOG_DIR=/var/log/slurm
ARG SLURM_PID_DIR=/run/slurm

# Install packages.
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get -y install --no-install-recommends slurmdbd \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Copy the slurmdbd supervisor definition file.
COPY etc/supervisor/conf.d/slurmdbd.conf /etc/supervisor/conf.d/

# Prepare directories for slurmdbd.
# Ownership is assigned to the user "slurm" created by the Ubuntu package.
RUN mkdir -p "$SLURM_LOG_DIR" "$SLURM_PID_DIR" \
    && chown "slurm:slurm" "$SLURM_LOG_DIR" "$SLURM_PID_DIR"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--nodaemon"]

VOLUME ["/ipaadmin"]
EXPOSE 22
EXPOSE 6819
