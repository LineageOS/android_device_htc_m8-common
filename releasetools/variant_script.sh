#!/sbin/sh

set -e

# Detect variant and create symlinks to its specific-blobs
modelid=`getprop ro.boot.mid`

case $modelid in
    "0P6B20000") variant="vzw" ;;
    "0P6B70000") variant="spr" ;;
    "0P6B61000") variant="dug" ;;
    "0P6B64000") variant="dug" ;;
    "0P6B68000") variant="dug" ;;
    "0P6B41000") variant="dwg" ;;
    "0P6B13000") variant="gsm"; tmo="true" ;;
    *)           variant="gsm" ;;
esac

# CDMA variants need a slight change to their gps.conf
if [ "$variant" == "vzw" ] || [ "$variant" == "spr" ] || [ "$variant" == "dwg" ]; then
  sed -i "s|PHONE_TYPE=UMTS|PHONE_TYPE=CDMA|g" /system/etc/gps.conf
fi

# Skip symlink creation for Dual SIM variants because blobs are already in the proper location
if [ "$variant" == "vzw" ] || [ "$variant" == "spr" ] || [ "$variant" == "gsm" ]; then
  basedir="/system/blobs/$variant/"
  cd $basedir
  chmod 755 bin/*
  find . -type f | while read file; do ln -s $basedir$file /system/$file ; done
fi

exit 0
