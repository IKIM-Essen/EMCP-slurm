ARG SLURMBASE

FROM ${SLURMBASE}

# Install packages.
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get -y install --no-install-recommends slurmctld \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Copy the supervisor definition files.
COPY etc/supervisor/conf.d/slurmctld.conf /etc/supervisor/conf.d/

EXPOSE 6817
