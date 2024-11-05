#!/usr/bin/env bash

# variable
AUTONOMYS_VERSION="24.11.05.22.48"
AUTONOMYS_DIR="~/autonomys"

space_acres() {
mkdir -p "$AUTONOMYS_DIR"
if [ ! -f "$AUTONOMYS_DIR/space-acres-0.1.38-x86_64.AppImage" ]; then
  wget https://github.com/autonomys/space-acres/releases/download/0.1.38/space-acres-0.1.38-x86_64.AppImage
fi
cd "$AUTONOMYS_DIR"
chmod u+x "space-acres-0.1.38-x86_64.AppImage"
./space-acres-0.1.38-x86_64.AppImage"  --appimage-extract
./squashfs-root/AppRun
}

select_item() {
    echo "1. space-acres-0.1.38-x86_64.AppImage"
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
