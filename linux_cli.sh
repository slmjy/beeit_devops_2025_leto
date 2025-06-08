#!/bin/bash
echo "Shell: $SHELL"
echo "Uživatel: $(whoami)"
echo "Verze Linuxu:"
cat /etc/os-release

# Vytvoření zanořených adresářů
mkdir -p ~/usr/adresar/podadresar/posledniadresar

# Vytvoření souboru s textem
echo "Ahoj ze sveta Linux" > ~/usr/adresar/podadresar/posledniadresar/soubor.txt

# Vytvoření soft linku
ln -s ~/usr/adresar/podadresar/posledniadresar/soubor.txt /tmp/sofLink

# Kopírování souboru do /tmp
cp ~/usr/adresar/podadresar/posledniadresar/soubor.txt /tmp/

# Výpis UID a GID uživatele
echo "UID: $(id -u)"
echo "GID: $(id -g)"

# Nastavení práv: ostatní pouze read-only
chmod o=r ~/usr/adresar/podadresar/posledniadresar/soubor.txt

# Nastavení práv pro symlink: execute pouze pro vlastníka
chmod 700 /tmp/sofLink
