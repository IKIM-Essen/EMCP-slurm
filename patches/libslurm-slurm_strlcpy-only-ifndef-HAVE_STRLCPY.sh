# slurm_strlcpy only only defined ifndef HAVE_STRLCPY
#
# Later versions have "(optional)" declaration already in place.

sed -i debian/libslurm*.symbols -e '
/^ slurm_strlcpy@Base 1.3.8/ s/^ / (optional)/
'
