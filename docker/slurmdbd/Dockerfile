ARG SLURMBASE

FROM ${SLURMBASE}

# Install packages.
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get -y install --no-install-recommends slurmdbd \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Copy the supervisor definition files.
COPY etc/supervisor/conf.d/slurmdbd.conf /etc/supervisor/conf.d/

EXPOSE 6819
