ARG BASE_IMG

FROM ${BASE_IMG}

# Install packages.
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get -y install --no-install-recommends slurmctld \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Copy the slurmctld supervisor definition file.
COPY etc/supervisor/conf.d/slurmctld.conf /etc/supervisor/conf.d/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--nodaemon"]

VOLUME ["/ipaadmin"]
EXPOSE 22
EXPOSE 6817
