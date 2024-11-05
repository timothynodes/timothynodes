#!/usr/bin/env bash

# variable
OCM_VERSION="24.11.05.20.54"

update_ocm_script() {
cd ~ && rm -rf ocm.sh && wget https://raw.githubusercontent.com/timothynodes/timothynodes/refs/heads/main/ocm.sh  && chmod u+x ocm.sh && ./ocm.sh
echo -e "The script has been updated to the latest version!" && exit 0
}

select_item() {
    clear
    echo "ocm.sh version 24.11.05.20.54"
    echo "1. Update ocm.sh"
    echo "0. Exit"
    read -rp "Select item:" item
    case "$item" in
    1)
        update_ocm_script
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
