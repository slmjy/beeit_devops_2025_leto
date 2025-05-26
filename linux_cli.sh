#!/bin/bash

# Aktuálně používaný shell
echo "Aktuální shell: $SHELL"

# Uživatel
echo "Aktuální uživatel: $(whoami)"

# Verze Linuxu
echo "Verze Linuxu:"
cat /etc/os-release
