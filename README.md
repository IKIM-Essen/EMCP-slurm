# EMCP slurm build

This repository contains CI workflows for building the slurm packages deployed in the [Essen Medical Computing Platform][emcp-paper].
For the Ansible deployment playbook, see [EMCP config][emcp-config].

[emcp-paper]: https://ieeexplore.ieee.org/document/9750320
[emcp-config]: https://github.com/IKIM-Essen/EMCP-config

## Building the slurmctld container image

Changes to the `docker` directory trigger the container image workflow. The image is built and pushed to the Github package repository.

## Building the deb packages

To trigger the deb build workflow, create a tag with the format `*.*.*-*` matching a slurm version number from the Ubuntu source repositories. For example, the tag `21.08.5-2ubuntu1` rebuilds the corresponding slurm version with nvml support.
