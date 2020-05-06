#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="JammaPi"
rp_module_desc="JammaPi Driver"
rp_module_help="This install the latest JammaPi driver. IMPORTANT: If you enable this driver, you will only see the video through JammaPi"
rp_module_section="driver"
rp_module_flags="noinstclean !all rpi"

function depends_jammapi() {
    local depends=(libjpeg-dev)
    isPlatform "rpi" && depends+=(libraspberrypi-dev raspberrypi-bootloader raspberrypi-kernel raspberrypi-kernel-headers)

    getDepends "${depends[@]}"
}

function sources_jammapi() {
    if [[ -d "$md_inst" ]]; then
        git -C "$md_inst" reset --hard  # ensure that no local changes exist
    fi
    gitPullOrClone "$md_inst" https://github.com/vince87/JammaPi.git
}

function install_jammapi() {
    cd "$md_inst"
    bash install.sh
}

function remove_jammapi() {
    cd "$md_inst"
    bash uninstall.sh
}

function gui_jammapi() {
    bash ~/JammaPi/script/menu.sh
}

function gui_jammapi() {
    local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option." 22 86 16)
    local options=(
        1 "Enable PowerBlock driver"
        2 "Disable PowerBlock driver"

    )
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                install_jammapi
                printMsgs "dialog" "Enabled JammaPi driver."
                ;;
            2)
                remove_jammapi
                printMsgs "dialog" "Disabled JammaPi driver."
                ;;
        esac
    fi
}
