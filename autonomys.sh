#!/usr/bin/env bash

# variable
AUTONOMYS_VERSION="24.11.13.12.42"
AUTONOMYS_DIR="ocm/autonomys"
NODE_DATA_PATH=""
YOUR_NODE_NAME=""
WALLET_ADDRESS=""
NODE_RPC_URL=""
PATH_TO_FARM=""
PATH_TO_NODE=""
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
if [ ! -f "space-acres-0.2.3-x86_64.AppImage" ]; then
  # apt_upgrade
  wget https://ghp.ci/https://github.com/autonomys/space-acres/releases/download/0.2.3/space-acres-0.2.3-x86_64.AppImage
  chmod_wget
  ./space-acres-0.2.3-x86_64.AppImage  --appimage-extract
fi
./squashfs-root/AppRun
}

space_node() {
change_dir
if [ ! -f "subspace-node-ubuntu-x86_64-skylake-mainnet-2024-nov-13" ]; then
  # apt_upgrade
  wget https://ghp.ci/https://github.com/autonomys/subspace/releases/download/mainnet-2024-nov-13/subspace-node-ubuntu-x86_64-skylake-mainnet-2024-nov-13
  chmod_wget
  ln -s subspace-node-ubuntu-x86_64-skylake-mainnet-2024-nov-13 subspace-node
fi
if [ -z "$PATH_TO_NODE" ]; then
  echo "ex : /node"
  read -rp "PATH_TO_NODE : " PATH_TO_NODE
fi
./subspace-node run \
  --chain mainnet \
  --blocks-pruning 256 \
  --state-pruning archive-canonical \
  --farmer \
  --base-path $PATH_TO_NODE \
  --rpc-cors all  --rpc-methods unsafe  \
  --in-peers 32 --out-peers 8 --rpc-listen-on  0.0.0.0:9944 \
  --listen-on /ip4/0.0.0.0/tcp/30333 \
  --dsn-listen-on /ip4/0.0.0.0/tcp/30433
}

space_farmer() {
change_dir
if [ ! -f "subspace-farmer-ubuntu-x86_64-skylake-mainnet-2024-nov-13" ]; then
  # apt_upgrade
  wget https://ghp.ci/https://github.com/autonomys/subspace/releases/download/mainnet-2024-nov-13/subspace-farmer-ubuntu-x86_64-skylake-mainnet-2024-nov-13
  chmod_wget
  ln -s subspace-farmer-ubuntu-x86_64-skylake-mainnet-2024-nov-13 subspace-farmer
fi
if [ -z "$WALLET_ADDRESS" ]; then
  read -rp "WALLET_ADDRESS : " WALLET_ADDRESS
fi
if [ -z "$NODE_RPC_URL" ]; then
  echo "ex : ws://127.0.0.1:9944"
  read -rp "NODE_RPC_URL : " NODE_RPC_URL
fi
if [ -z "$PATH_TO_FARM" ]; then
  echo "ex : /farmer"
  read -rp "PATH_TO_FARM : " PATH_TO_FARM
fi
if [ -z "$PLOT_SIZE" ]; then
  echo "ex : 2G"
  read -rp "PLOT_SIZE : " PLOT_SIZE
fi
./subspace-farmer farm \
  --reward-address $WALLET_ADDRESS \
  --node-rpc-url $NODE_RPC_URL \
  --listen-on /ip4/0.0.0.0/tcp/30533 \
  path=$PATH_TO_FARM,size=$PLOT_SIZE
}

select_item() {
  echo "1. Autonomys(Ubuntu 24.04)space-acres       0.2.0-x86_64.AppImage"
  echo "2. Autonomys(Linux CLI)subspace-node        2024-nov-13"
  echo "3. Autonomys(Linux CLI)subspace-farmer      2024-nov-13" 
  echo "0. Exit"
  read -rp "Select item:" item
  case "$item" in
  1)
    space_acres
    ;;
  2)
    space_node
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
