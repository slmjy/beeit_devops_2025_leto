echo "Shell: $SHELL"
whoami
sw_vers
# musela jsem pouzit ~ pro vytvoreni v domacim adresari, jinak jsem ani se sudo nemela prava..
mkdir -p ~/usr/adresar/podadresar/posledniadresar/
cd ~/usr/adresar/podadresar/posledniadresar/
touch soubor.txt
echo "Ahoj ze sveta Linux" > soubor.txt
ln -s soubor.txt /tmp/sofLink
cp soubor.txt /tmp/
id -u
id -g
chmod o=r
# tohle jsem teda popravde musela najit
chmod -h u+x,go= /tmp/sofLink
