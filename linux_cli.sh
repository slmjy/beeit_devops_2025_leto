#!/bin/bash

# Aktuálně používaný shell
echo "Aktuální shell: $SHELL"

# Uživatel
echo "Aktuální uživatel: $(whoami)"

# Verze Linuxu
echo "Verze Linuxu:"
cat /etc/os-release

# Cesta k adresaru
DIR_PATH="/usr/adresar/podadresar/posledniadresar"

# Vytvorenie zanoreneho adresaru
sudo mkdir -p "$DIR_PATH"

# Vytvorenie suboru so spravou
echo "Ahoj ze sveta Linux" | sudo tee "$DIR_PATH/soubor.txt" > /dev/null

# Vytvorenie soft linku do /tmp
sudo ln -s "$DIR_PATH/soubor.txt" /tmp/sofLink

# Kopirovanie souboru.txt do /tmp
sudo cp "$DIR_PATH/soubor.txt" /tmp/

# Výpis UID a GID uzivatele
echo "UID: $(id -u)"
echo "GID: $(id -g)"

# Nastavenie práv na soubor.txt (read-only pro ostatní)
sudo chmod o=r "$DIR_PATH/soubor.txt"

# Nastavení práv na soft link – execute pro vlastníka, ziadne práva pre ostatnych
sudo chmod 100 /tmp/sofLink
