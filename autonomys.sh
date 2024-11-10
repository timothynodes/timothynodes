#!/usr/bin/env bash

# variable
AUTONOMYS_VERSION="24.11.10.13.55"
AUTONOMYS_DIR="autonomys"
NODE_DATA_PATH=""
YOUR_NODE_NAME=""
WALLET_ADDRESS=""
NODE_RPC_URL=""
PATH_TO_FARM=""
PLOT_SIZE=""

change_dir() {
  cd ~
  mkdir -p "$AUTONOMYS_DIR"
  cd "$AUTONOMYS_DIR"
  # mkdir -p "$PATH_TO_FARM"
}

chmod_wget() {
  chmod u+x s*
}

apt_upgrade() {
  # echo "deb http://cz.archive.ubuntu.com/ubuntu jammy main" | sudo tee -a /etc/apt/sources.list && \
  sudo apt update && \
  sudo apt upgrade -y && \
  sudo apt install libc6 -y && \
  sudo apt install libpango-1.0-0 -y
}

space_acres() {
change_dir
if [ ! -f "space-acres-0.2.0-x86_64.AppImage" ]; then
  # apt_upgrade
  wget https://ghp.ci/https://github.com/autonomys/space-acres/releases/download/0.2.0/space-acres-0.2.0-x86_64.AppImage
  chmod_wget
  ./space-acres-0.2.0-x86_64.AppImage  --appimage-extract
fi
./squashfs-root/AppRun
}

space_acres_rm() {
change_dir
rm -f space-acres-0.2.0-x86_64.AppImage
}

space_farmer() {
change_dir
if [ ! -f "subspace-farmer-ubuntu-x86_64-skylake-mainnet-2024-nov-06" ]; then
  # apt_upgrade
  wget https://ghp.ci/https://github.com/autonomys/subspace/releases/download/mainnet-2024-nov-06/subspace-farmer-ubuntu-x86_64-skylake-mainnet-2024-nov-06
  chmod_wget
fi
if [ -z "$WALLET_ADDRESS" ]; then
  read -rp "WALLET_ADDRESS : " WALLET_ADDRESS
fi
if [ -z "$NODE_RPC_URL" ]; then
  read -rp "NODE_RPC_URL : " NODE_RPC_URL
fi
if [ -z "$PATH_TO_FARM" ]; then
  read -rp "PATH_TO_FARM : " PATH_TO_FARM
fi
if [ -z "$PLOT_SIZE" ]; then
  read -rp "PLOT_SIZE : " PLOT_SIZE
fi
./subspace-farmer-ubuntu-x86_64-skylake-mainnet-2024-nov-06 farm \
  --reward-address $WALLET_ADDRESS \
  --node-rpc-url $NODE_RPC_URL \
  --listen-on /ip4/0.0.0.0/tcp/30533 \
  path=$PATH_TO_FARM,size=$PLOT_SIZE
}

select_item() {
  echo "1. Autonomys(GUI-Linux)space-acres       0.2.0-x86_64.AppImage"
  echo "2. Autonomys(GUI-Linux)space-acres rm -f 0.2.0-x86_64.AppImage"
  echo "3. Autonomys(CLI-Linux)subspace-farmer 2024-nov-06"
  echo "4. Autonomys(CLI-Linux)subspace-node   2024-nov-06(Coming soon)"  
  echo "0. Exit"
  read -rp "Select item:" item
  case "$item" in
  1)
    space_acres
    ;;
  2)
    space_acres_rm
    ;;
  3)
    space_farmer
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
