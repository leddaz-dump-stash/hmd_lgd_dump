#!/vendor/bin/sh
# SPDX-FileCopyrightText: 2016-2023 Unisoc (Shanghai) Technologies Co., Ltd
# SPDX-License-Identifier: LicenseRef-Unisoc-General-1.0

kernel_version=$(uname -r)
kernel_main_ver=${kernel_version%.*}

while :
do
        if [ $kernel_main_ver != 5.4 ]; then
                break
        fi

        time=`uptime | awk '{print $3}'`
        if [ $time -lt 4 ]; then
                sleep 10
        else
                #[MBW][LGD][LGD-679] Add Virtual RAM  by zhoujixu 2023/11/10 begin
                #setprop vendor.zram.limit yes
                #[MBW][LGD][LGD-679] Add Virtual RAM  by zhoujixu 2023/11/10 end
                sleep 2
                setprop vendor.zram.writeback idle
                sleep 2
                setprop vendor.zram.writeback idle_fast
                break
        fi
done
