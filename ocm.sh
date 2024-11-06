#!/usr/bin/env bash

# variable
OCM_VERSION="24.11.06.23.04"

update_ocm_script() {
# cd ~ && rm -rf ocm.sh && wget https://raw.githubusercontent.com/timothynodes/timothynodes/refs/heads/main/ocm.sh && chmod u+x ocm.sh && ./ocm.sh
cd ~ && rm -rf ocm.sh_new && wget https://raw.githubusercontent.com/timothynodes/timothynodes/refs/heads/main/ocm.sh -O ocm.sh_new
if [ ! -f "~/ocm.sh_new" ]; then
  rm -rf ocm.sh && mv ocm.sh_new ocm.sh
fi
echo -e "The script has been updated to the latest version!"
sleep 2s
chmod u+x ocm.sh && ./ocm.sh
}

select_item() {
    echo "ocm.sh version 24.11.06.23.04"
    echo "https://t.me/ocm_g"
    update_ocm_script
    echo "1. Update ocm.sh"
    echo "2. Autonomys(Subspace)(OS:Ubuntu desktop)"
    echo "0. Exit"
    read -rp "Select item:" item
    case "$item" in
    1)
        update_ocm_script
        ;;
    2)
        cd ~ && rm -rf autonomys.sh && wget https://raw.githubusercontent.com/timothynodes/timothynodes/refs/heads/main/autonomys.sh && chmod u+x autonomys.sh && ./autonomys.sh
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
