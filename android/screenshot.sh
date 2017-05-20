#!/bin/sh
date=`date +"%Y-%m-%d_%H.%M.%S"`
file="$1_$date.png"

adb shell /system/bin/screencap -p /sdcard/$file
adb pull /sdcard/$file ~/$file
