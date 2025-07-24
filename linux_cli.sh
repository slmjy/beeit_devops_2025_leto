#!/bin/bash

# Vypíše název aktuálního shellu
echo "Používaný shell: $SHELL"

# Vypíše jméno aktuálního uživatele
echo "Aktuální uživatel: $USER"

# Vypíše verzi jádra Linuxu
echo "OS:"
cat /etc/os-release
sudo mkdir -p /usr/adresar/podadresar/posledniadresar/
sudo touch /usr/adresar/podadresar/posledniadresar/soubor.txt
echo "Ahoj ze sveta Linux" > soubor.txt
sudo sh -c 'echo "Ahoj ze sveta Linux" > /usr/adresar/podadresar/posledniadresar/soubor.txt'
ln -s /usr/adresar/podadresar/posledniadresar/soubor.txt /tmp/softLink
echo "Soft link byl vytvořen v /tmp/softLink."
cp /usr/adresar/podadresar/posledniadresar/soubor.txt /tmp/
echo "Soubor soubor.txt byl nakopírován do /tmp/."
echo "UID a GID aktuálního uživatele:"
id
sudo chmod o=r /usr/adresar/podadresar/posledniadresar/soubor.txt
echo "Práva souboru soubor.txt byla změněna na read only pro ostatní uživatele."
chmod u+x,go-rwx /tmp/softLink
echo "Práva soft linku /tmp/softLink byla změněna (execute pro vlastníka, žádná pro ostatní a skupinu)."
