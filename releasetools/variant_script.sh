#!/sbin/sh

set -e

# Detect variant
modelid=`getprop ro.boot.mid`

case $modelid in
    "0P6B20000") variant="vzw" ;;
    "0P6B70000") variant="spr" ;;
    "0P6B61000"|"0P6B64000"|"0P6B68000") variant="dug" ;;
    "0P6B41000") variant="dwg" ;;
    "0P6B13000") variant="gsm"; tmo="true" ;;
    *)           variant="gsm" ;;
esac

# CDMA variants need a slight change to their gps.conf
if [ "$variant" == "vzw" ] || [ "$variant" == "spr" ] || [ "$variant" == "dwg" ]; then
  sed -i "s|PHONE_TYPE=UMTS|PHONE_TYPE=CDMA|g" /system/etc/gps.conf
fi

exit 0
