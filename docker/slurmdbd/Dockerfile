ARG SLURM_COMPONENT="slurmdbd"

FROM ../slurmbase/Dockerfile

# Install packages.
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends slurmdbd \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Copy the slurmdbd supervisor definition file.
COPY etc/supervisor/conf.d/slurmdbd.conf /etc/supervisor/conf.d/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--nodaemon"]

VOLUME ["/ipaadmin"]
EXPOSE 22
EXPOSE 6819
