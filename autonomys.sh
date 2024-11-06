#!/usr/bin/env bash

# variable
AUTONOMYS_VERSION="24.11.06.23.15"
AUTONOMYS_DIR="autonomys"

space_acres() {
cd ~
mkdir -p "$AUTONOMYS_DIR"
cd "$AUTONOMYS_DIR"
if [ ! -f "space-acres-0.2.0-x86_64.AppImage" ]; then  
  wget https://ghp.ci/https://github.com/autonomys/space-acres/releases/download/0.2.0/space-acres-0.2.0-x86_64.AppImage
  chmod u+x space-acres-0.2.0-x86_64.AppImage
  ./space-acres-0.2.0-x86_64.AppImage  --appimage-extract
fi
./squashfs-root/AppRun
}

select_item() {
    echo "1. space-acres-0.2.0-x86_64.AppImage"
    echo "0. Exit"
    read -rp "Select item:" item
    case "$item" in
    1)
        space_acres
        ;;
    0)
        exit 1
        ;;
    *)
        clear
        sleep 1s
        select_item
        ;;
    esac
}
select_item
