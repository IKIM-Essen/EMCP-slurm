# Add slurm-wlm-nvml-plugin
#
# Package definitions are from slurm-wlm-contrib.

sed -i debian/control -e '
/^Build-Depends:/ a\
 libnvidia-ml-dev,

$ a\
\
Package: slurm-wlm-nvml-plugin\
Section: contrib/libs\
Architecture: any\
Depends:\
 ${shlibs:Depends},\
 ${misc:Depends},\
 slurm-wlm-basic-plugins (= ${binary:Version})\
Enhances: slurmd (= ${binary:Version})\
Description: SLURM NVML plugins\
 SLURM, the Simple Linux Utility for Resource Management,\
 is an open-source cluster resource management and job scheduling.\
 .\
 This package contains the Nvidia NVML-based SLURM plugin.\
\
Package: slurm-wlm-nvml-plugin-dev\
Section: contrib/devel\
Architecture: any\
Depends:\
 ${shlibs:Depends},\
 ${misc:Depends},\
 slurm-wlm-basic-plugins-dev (= ${binary:Version}),\
 slurm-wlm-nvml-plugin (= ${binary:Version}),\
 libnvidia-ml-dev,\
Description: SLURM NVML plugin development files\
 SLURM, the Simple Linux Utility for Resource Management,\
 is an open-source cluster resource management and job scheduling.\
 .\
 This package contains development files for the Nvidia NVML-based\
 SLURM plugins.\
'

sed -i debian/rules -e '
/^override_dh_strip:/ a\\tdh_strip -pslurm-wlm-nvml-plugin
'

cat > debian/slurm-wlm-nvml-plugin.install << 'EOF'
usr/lib/*/slurm-wlm/gpu_nvml.so
EOF

cat > debian/slurm-wlm-nvml-plugin-dev.install << 'EOF'
usr/lib/*/slurm-wlm/gpu_nvml.a
usr/lib/*/slurm-wlm/gpu_nvml.la
EOF
