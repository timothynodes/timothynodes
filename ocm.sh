#!/usr/bin/env bash

# variable
OCM_VERSION="24.11.17.00.30"

update_ocm_script() {
  cd ~ && rm -rf ocm.sh && wget https://ghp.ci/https://raw.githubusercontent.com/timothynodes/timothynodes/refs/heads/main/ocm.sh && chmod u+x ocm.sh && ./ocm.sh
}

select_item() {
  mkdir -p ocm
    echo "ocm.sh version 24.11.17.00.30"
    echo "https://t.me/ocm_g"
    echo "1. Update ocm.sh"
    echo "2. Autonomys(subspace)Linux"
    echo "0. Exit"
    read -rp "Select item:" item
    case "$item" in
    1)
        update_ocm_script
        ;;
    2)
        cd ~ && rm -rf autonomys.sh && wget https://ghp.ci/https://raw.githubusercontent.com/timothynodes/timothynodes/refs/heads/main/autonomys.sh && chmod u+x autonomys.sh && ./autonomys.sh
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
