#!/usr/bin/env bash

# variable
OCM_VERSION="24.11.05.20.08"

    case "$num" in
    1)
        update_shell
        ;;
    20)
        new_account
        ;;
    0)
        exit 1
        ;;
    *)
        clear
        if [ "$LANGUAGE" == "cn" ]; then
            red "请输入正确数字 (0-20)"
        else
            red "Please enter the correct number (0-20)"
        fi
        sleep 1s
        start_menu
        ;;
    esac
