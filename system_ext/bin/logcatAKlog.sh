#!bin/sh

function logcmd()
{
    echo -e "\n"
}

function exe_cmd()
{
    logcmd "$@";
    eval $@;
}

if [ $# == 0 ];then
    log_path_prop=sys.debug.logbuffer.path
    log_path=$(getprop $log_path_prop)

    if [ -d $log_path ];then
        exe_cmd "dmesg -T > $log_path/kernel.log"
        exe_cmd "logcat -d > $log_path/android.log"
    fi
elif [ $1 == "--dumpinfo" ];then
    dump_prop=sys.debug.dumpinfo.type
    dump_type=$(getprop $dump_prop)
    dump_time=$(date "+%Y-%m-%d-%H-%M-%S")
    dstdir="/data/ylog/dynamiclog/"
    dump_type=${dump_type//;/ }
    for element in $dump_type
    do
        if [ $element == "activity" ];then
            exe_cmd "dumpsys activity > $dstdir${dump_time}_activity.txt"
        elif [ $element == "window" ]; then
            exe_cmd "dumpsys window > $dstdir${dump_time}_window.txt"
        elif [ $element == "sf" ]; then
            exe_cmd "dumpsys SurfaceFlinger > $dstdir${dump_time}_sf.txt"
        elif [ $element == "hprof" ]; then
            exe_cmd "am dumpheap system /data/ylog/hprofs/${dump_time}_server.hprof"
            exe_cmd "am dumpheap com.android.systemui /data/ylog/hprofs/${dump_time}_systemui.hprof"
            exe_cmd "am dumpheap com.android.launcher3 /data/ylog/hprofs/${dump_time}_launcher3.hprof"
        fi
    done
fi
echo "done"
