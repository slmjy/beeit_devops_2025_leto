#!/bin/bash
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

create_directory() {
    if mkdir -p "$1"; then
        echo "Vytvoren adresar $1"
    else 
        echo "Doslo k chybe"
    fi
}

create_link() {
    TYPE=$1
    SOURCE=$2
    TARGET=$3
#-e existuje
     if [ -e "$TARGET" ]; then
        echo "Link '$TARGET' uz existuje"
        exit 2
    fi

    if [ "$TYPE" = "soft" ]; then
        ln -s "$SOURCE" "$TARGET"
        echo "Vytvoren soft link"
    else
        ln "$SOURCE" "$TARGET"
        echo "Vytvoren hard link"
    fi

    if [ $? -ne 0 ]; then
        echo "Nepodarilo se vytvorit link."
        exit 1
    fi
}

info_user() {
    echo "User ID: $(id -u)"
    echo "Hostname: $(hostname)"
    echo "Date: $(date)"
}

list_update() {
    echo "Vsechny balicky, ktere maji update:"
    apt list --upgradable
}

update_upgrade() {
    echo "Update/Upgrade balicku"
    sudo apt update && sudo apt upgrade
}


LOG_TO_FILE=false
LOG_FILE="./log_file.txt"

log() {
    if $LOG_TO_FILE; then
        echo "$1" >> "$LOG_FILE"
    else
        echo "$1"
    fi
}

print_help() {
    cat << EOF

Zkratky:
  -m PATH           Vytvoreni adresare, popripade jeho zanorene struktury napr. např. ./script.sh -m /usr/novyadresar/podadresar
  -l TYPE SOURCE TARGET   Vytvori link (soft nebo hard) 
  -i                 Zakladni info o uzivateli
  -u                 Vylistuje vsechny balicky, ktere maji update
  -g                 Update a upgrade balicku
  -s                 Zapne logovani do souboru nebo STDOUT
  -h                 Zobrazi napovedu
EOF
}

while getopts "m:l:iugo:h" opt; do
    case {$opt} in
        m)
            create_directory "$OPTARG";;
            exit 0
        l)
            create_link "$OPTARG";;
            exit 0
        i)
            info_user;;
            exit 0
        u)
            list_update;;
            exit 0
        g)
            update_upgrade;;
            exit 0
        o)
            LOG_TO_FILE=true
            LOG_FILE="$OPTARG";;
            ecit 0
        h)
            print_help;;
            exit 0
        *)
            echo "Neco se pokazilo. Dej -h pro napovedu";;
            exit 1
            
    esac
done

# MAC adresa
ip link
# IPv4 a IPv6
ip a

