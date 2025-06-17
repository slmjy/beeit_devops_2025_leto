#!/bin/bash

# -----------------------------------------
# Nápověda k použití (-h)
# -----------------------------------------
show_help() {
  echo "Použití: ./linux_cli.sh [možnosti]"
  echo ""
  echo "Možnosti:"
  echo "  -h                     Zobrazí tuto nápovědu"
  echo "  -m /cesta              Vytvoří zanořený adresář a soubor soubor.txt"
  echo "  -l typ:zdroj:cíl       Vytvoří link (typ = soft | hard)"
  echo "  -i                     Vypíše ID uživatele, hostname a datum"
  echo "  -u                     Vypíše dostupné aktualizace balíčků"
  echo "  -U                     Spustí aktualizaci systému (sudo apt update && upgrade)"
  echo "  -o log.txt / stdout    Zapíše výstup do souboru nebo na obrazovku"
}

# -----------------------------------------
# LOGOVÁNÍ: výchozí výstup je na obrazovku
# -----------------------------------------
LOGFILE="stdout"

log() {
  if [[ "$LOGFILE" == "stdout" ]]; then
    echo "$1"
  else
    echo "$1" >> "$LOGFILE"
  fi
}

# -----------------------------------------
# Zpracování logovací volby -o
# -----------------------------------------
if [[ "$1" == "-o" && -n "$2" ]]; then
  LOGFILE="$2"
  shift 2
fi

# -----------------------------------------
# Nápověda -h
# -----------------------------------------
if [[ "$1" == "-h" ]]; then
  show_help
  exit 0
fi

# -----------------------------------------
# Úkol 1: Vytvoření adresáře -m /cesta
# -----------------------------------------
if [[ "$1" == "-m" && -n "$2" ]]; then
  log "Vytvářím adresář: $2"
  mkdir -p "$2"
  echo "Ahoj ze sveta Linux" > "$2/soubor.txt"
  log "Soubor vytvořen: $2/soubor.txt"
  exit 0
fi

# -----------------------------------------
# Úkol 2: Vytvoření linku -l typ:zdroj:cíl
# -----------------------------------------
if [[ "$1" == "-l" && -n "$2" ]]; then
  IFS=':' read -r typ odkud kam <<< "$2"

  if [[ -e "$kam" || -L "$kam" ]]; then
    log "Chyba: link '$kam' už existuje. Skript končí."
    exit 3
  fi

  if [[ "$typ" == "soft" ]]; then
    ln -s "$odkud" "$kam"
    log "Vytvořen symbolický link: $kam → $odkud"
  elif [[ "$typ" == "hard" ]]; then
    ln "$odkud" "$kam"
    log "Vytvořen pevný link: $kam → $odkud"
  else
    log "Chyba: typ musí být soft nebo hard"
    exit 1
  fi
  exit 0
fi

# -----------------------------------------
# Úkol 3: Výpis základních info -i
# -----------------------------------------
if [[ "$1" == "-i" ]]; then
  log "ID uživatele: $(id -u)"
  log "Hostname: $(hostname)"
  log "Datum a čas: $(date)"
  exit 0
fi

# -----------------------------------------
# Úkol 4: Seznam dostupných aktualizací -u
# -----------------------------------------
if [[ "$1" == "-u" ]]; then
  log "Dostupné aktualizace balíčků:"
  apt list --upgradable 2>/dev/null | while read -r line; do log "$line"; done
  exit 0
fi

# -----------------------------------------
# Úkol 5: Update systému -U
# -----------------------------------------
if [[ "$1" == "-U" ]]; then
  log "Spouštím aktualizaci systému..."
  sudo apt update && sudo apt upgrade -y
  log "Aktualizace dokončena."
  exit 0
fi

# -----------------------------------------
# PŮVODNÍ ÚKOLY Z DŘÍVĚJŠÍCH LEKCÍ
# -----------------------------------------

log "Verze Linuxu:"
cat /etc/os-release

# Vytvoření zanořených adresářů
mkdir -p /usr/adresar/podadresar/posledniadresar

# Vytvoření souboru s textem
echo "Ahoj ze sveta Linux" > /usr/adresar/podadresar/posledniadresar/soubor.txt

# Vytvoření symbolického linku
ln -sf /usr/adresar/podadresar/posledniadresar/soubor.txt /tmp/softLink

# Zkopírování souboru do /tmp
cp /usr/adresar/podadresar/posledniadresar/soubor.txt /tmp/

# Výpis UID a GID
log "UID: $(id -u)"
log "GID: $(id -g)"

# Změna práv: ostatní pouze čtení
chmod o=r /usr/adresar/podadresar/posledniadresar/soubor.txt

# Změna práv na symbolický link: execute pro vlastníka, žádná práva pro ostatní
chmod 100 /tmp/softLink
