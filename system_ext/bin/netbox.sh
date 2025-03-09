#!/system/bin/sh
# SPDX-FileCopyrightText: 2016-2023 Unisoc (Shanghai) Technologies Co., Ltd
# SPDX-License-Identifier: LicenseRef-Unisoc-General-1.0

LOG_TAG="netbox.sh"

function exe_log()
{
	local cmd="$@"
	local emsg="$(eval $cmd 2>&1)"

	log -p d -t "$LOG_TAG" "$cmd ecode=$? $emsg"
}

function gro_switch()
{
	for fileGro in $(ls /sys/devices/platform/sipa-eth*/gro_enable)
		do
			exe_log "echo $1 > $fileGro";
		done

	exe_log "echo $1 > /sys/module/seth/parameters/gro_enable"
}

if [ "$1" == "gro" ]; then
	if [ "$2" == "on" ]; then
		gro_switch 1;
	elif [ "$2" == "off" ]; then
		gro_switch 0;
	fi
fi
