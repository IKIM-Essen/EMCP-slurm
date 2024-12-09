# Drop dpkg-dev, debhelper min version constraints
#
# We want to build on older Ubuntu versions that cannot satisfy these
# constraints -- so, fingers crossed that nothing major requires them...

sed -i debian/control -e '
s/ dpkg-dev (>= [^)]*),/ dpkg-dev,/
s/ debhelper (>= [^)]*),/ debhelper,/
'
