# Remove slurm-wlm-rsmi-plugin
#
# Ubuntu <23.04 does not have librocm-smi-dev.

sed -i debian/control -e '
/^ librocm-smi-dev,\?/ d
/^ slurm-wlm-rsmi-plugin.*,/ d
/^Package: slurm-wlm-rsmi-plugin.*$/,/^$/ d
'

sed -i debian/rules -e '
/dh_strip -pslurm-wlm-rsmi-plugin/d
'

rm -f debian/slurm-wlm-rsmi-plugin*
