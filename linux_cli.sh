#!/bin/bash

# Úkol 3 + 4 zakomentovano 

# Aktuálně používaný shell
#echo "Aktuální shell: $SHELL"

# Uživatel
#echo "Aktuální uživatel: $(whoami)"

# Verze Linuxu
#echo "Verze Linuxu:"
#cat /etc/os-release

# Cesta k adresaru
#DIR_PATH="/usr/adresar/podadresar/posledniadresar"

# Vytvorenie zanoreneho adresaru
#sudo mkdir -p "$DIR_PATH"

# Vytvorenie suboru so spravou
#echo "Ahoj ze sveta Linux" | sudo tee "$DIR_PATH/soubor.txt" > /dev/null

# Vytvorenie soft linku do /tmp
#sudo ln -s "$DIR_PATH/soubor.txt" /tmp/sofLink

# Kopirovanie souboru.txt do /tmp
#sudo cp "$DIR_PATH/soubor.txt" /tmp/

# Výpis UID a GID uzivatele
#echo "UID: $(id -u)"
#echo "GID: $(id -g)"

# Nastavenie práv na soubor.txt (read-only pro ostatní)
#sudo chmod o=r "$DIR_PATH/soubor.txt"

# Nastavení práv na soft link – execute pro vlastníka, ziadne práva pre ostatnych
#sudo chmod 100 /tmp/sofLink

######################################################################################
# Úkol 5.
print_help() {
    echo "Použití: $0 [možnosti]"
    echo "Možnosti:"
    echo "  -m <cesta>                  Vytvoří zanořený adresář"
    echo "  -l <typ>:<zdroj>:<cil>      Vytvoří link (typ soft|hard)"
    echo "  -i                          Vypíše ID uživatele, hostname a datum"
    echo "  -u                          Vylistuje dostupné updaty balíčků"
    echo "  -U                          Provede update a upgrade systému"
    echo "  -o <soubor>                 Zapisuje výstup do souboru (jinak STDOUT)"
    echo "  -h                          Zobrazí nápovědu"
}

log() {
    if [[ -n "$OUTPUT_FILE" ]]; then
        echo "$1" >> "$OUTPUT_FILE"
    else
        echo "$1"
    fi
}

while getopts "m:l:iuUo:h" opt; do
    case "$opt" in
        m)
            DIR="$OPTARG"
            if sudo mkdir -p "$DIR"; then
                log "Adresář '$DIR' byl úspěšně vytvořen."
            else
                log "Nepodařilo se vytvořit adresář '$DIR'."
                exit 1
            fi
            ;;
        l)
            IFS=':' read -r TYPE SOURCE TARGET <<< "$OPTARG"
            if [[ -e "$TARGET" ]]; then
                log "Link '$TARGET' již existuje. Ukončuji."
                exit 2
            fi
            if [[ "$TYPE" == "soft" ]]; then
                if ln -s "$SOURCE" "$TARGET"; then
                    log "Soft link vytvořen z '$SOURCE' do '$TARGET'"
                else
                    log "Nepodařilo se vytvořit soft link."
                    exit 1
                fi
            elif [[ "$TYPE" == "hard" ]]; then
                if ln "$SOURCE" "$TARGET"; then
                    log "Hard link vytvořen z '$SOURCE' do '$TARGET'"
                else
                    log "Nepodařilo se vytvořit hard link."
                    exit 1
                fi
            else
                log "Neznámý typ linku '$TYPE'. Použijte 'soft' nebo 'hard'."
                exit 1
            fi
            ;;
        i)
            log "UID: $(id -u)"
            log "Hostname: $(hostname)"
            log "Datum: $(date)"
            ;;
        u)
            if command -v apt > /dev/null; then
                log "Dostupné updaty:"
                apt list --upgradeable 2>/dev/null | tee -a "$OUTPUT_FILE"
            else
                log "Tento systém nepoužívá apt, funkce není podporována."
            fi
            ;;
        U)
            if command -v apt > /dev/null; then
                sudo apt update && sudo apt upgrade -y
                log "Systém byl aktualizován."
            else
                log "Tento systém nepodporuje apt upgrade."
            fi
            ;;
        o)
            OUTPUT_FILE="$OPTARG"
            echo "Log bude uložen do: $OUTPUT_FILE"
            ;;
        h)
            print_help
            exit 0
            ;;
        *)
            print_help
            exit 1
            ;;
    esac
done

######################################################################################
# Úkol 6.
show_network_info() {
  echo "Síťové informace:"
  echo "-------------------"

  # Hlavní síťové rozhraní
  iface=$(ip route | grep default | awk '{print $5}')

  echo "Použité rozhraní: $iface"

  # IP adresy
  echo "IPv4 adresa: $(ip -4 addr show $iface | grep -oP '(?<=inet\s)\d+(\.\d+){3}')"
  echo "IPv6 adresa: $(ip -6 addr show $iface | grep -oP '(?<=inet6\s)[\da-f:]+')"

  # MAC adresa
  echo "MAC adresa: $(cat /sys/class/net/$iface/address)"

  # CIDR rozsah (předpokládá IPv4 + masku)
  cidr=$(ip -4 addr show $iface | grep -oP '(?<=inet\s)\d+\.\d+\.\d+\.\d+/\d+')
  echo "CIDR rozsah: $cidr"

  echo "-------------------"
}