#!bin/sh

function logcmd()
{
    echo -e "\n"
    echo -n "$@"
    echo -n " on "
    date '+%m-%d %T'
}

function exe_cmd()
{
    logcmd "$@";
    eval $@;
    echo -n "run finished on "
    date '+%m-%d %T'
}


count=0
while true;do
    sysinfo_date=$(date '+%m-%d %T')
    echo "sysinfo_"$count"  on "$sysinfo_date
    b=$(($count % 6))
    if [ $b -eq 0 ]; then
        exe_cmd "cat /proc/meminfo"
        exe_cmd "free"
        exe_cmd "vmstat"
        exe_cmd "df"
        exe_cmd "storaged -u"
        exe_cmd "cat /proc/uid_io/debug"
        exe_cmd "cat /proc/buddyinfo"
        exe_cmd "cat /proc/slabinfo"
        exe_cmd "cat /proc/zoneinfo"
        exe_cmd "cat /proc/vmstat"
        exe_cmd "cat /proc/vmallocinfo"
        exe_cmd "cat /proc/pagetypeinfo"
        exe_cmd "cat /d/wakeup_sources"
        exe_cmd "cat /dev/binderfs/binder_logs/failed_transaction_log"
        exe_cmd "cat /dev/binderfs/binder_logs/transaction_log"
        exe_cmd "cat /dev/binderfs/binder_logs/transactions"
        exe_cmd "cat /dev/binderfs/binder_logs/stats"
        exe_cmd "cat /dev/binderfs/binder_logs/state"
        exe_cmd "cat /proc/interrupts"
    else
        exe_cmd "storaged -u"
    fi
    count=$(($count+1))
    echo "sysinfo end\n\n\n"
    if [[ $1 == 1 ]]; then
        break
    fi
    #print sysinfo log every 20s
    sleep 20s
done
