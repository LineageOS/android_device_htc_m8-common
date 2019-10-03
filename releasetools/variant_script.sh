#!/sbin/sh
#
# Copyright (C) 2014-2016 The CyanogenMod Project
# Copyright (C) 2017,2019 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

# Helper functions
copy()
{
  LD_LIBRARY_PATH="$system_root/lib" "$system_root/bin/toybox" cp --preserve=a "$1" "$2"
}

# Detect where system is mounted
if [ -d /mnt/system ]; then
  system_root="/mnt/system/system"
elif [ -d /system_root ]; then
  system_root="/system_root/system"
else
  system_root="/system/system"
fi

# Detect variant and copy its specific-blobs
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

# Skip copying blobs in case of Dual SIM variants because the files are already in the proper location
if [ "$variant" == "vzw" ] || [ "$variant" == "spr" ] || [ "$variant" == "gsm" ]; then
  basedir="$system_root/vendor/blobs/$variant/"
  if [ -d $basedir ]; then
    cd $basedir

    for file in `find . -type f` ; do
      mkdir -p `dirname $system_root/vendor/$file`
      copy $file $system_root/vendor/$file
    done

    for file in bin/* ; do
      chmod 755 $system_root/vendor/$file
    done
  else
    echo "Expected source directory does not exist!"
    exit 1
  fi
fi

exit 0
