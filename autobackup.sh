#!/usr/bin/bash

if [ ! -z "$1" ]; then
    echo "[Auto] Argument detected"
    if [ "$1" == "ENABLE" ]; then
        echo "[Auto] Enabling autobackup"
        rm -f ~/.savefilesdisabled
    elif [ "$1" == "DISABLE" ]; then
        echo "[Auto] Disabling autobackup"
        touch ~/.savefilesdisabled
    else
        echo "[Auto] Unknown argument $1"
        echo "[Auto] Valid arguments are:"
        echo "[Auto]  ENABLE - Enable autobackup"
        echo "[Auto]  DISABLE - Disable autobackup"
    fi

    exit
fi

if [ -f "$HOME/.savefilesdisabled" ]; then
    echo "[Auto] Autobackup is disabled"
    exit
fi

echo "[Auto] Starting automatic backup"
cd "$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

notify-send "Started savefiles autobackup." -a "Savefiles" -i "$(pwd)/guiicon_hq.png"

notify-send "Updating repository." -a "Savefiles" -i "$(pwd)/guiicon_hq.png"
git pull

notify-send "Backing up." -a "Savefiles" -i "$(pwd)/guiicon_hq.png"
./backup.py backup

notify-send "Committing backup." -a "Savefiles" -i "$(pwd)/guiicon_hq.png"
git add saves
git commit -m "Automatic backup: $(date +"%F %T")"

notify-send "Uploading backup. This might take some time." -a "Savefiles" -i "$(pwd)/guiicon_hq.png"
git push
