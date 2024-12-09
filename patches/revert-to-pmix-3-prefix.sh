# Revert to PMIx 3 prefix
#
# libpmi paths in Ubuntu <21.04 have /usr/lib/*/pmix prefix.

sed -i debian/rules -e '
/--with-pmix=/ s|/pmix2|/pmix|g
'
