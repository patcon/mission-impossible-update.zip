#!/usr/bin/env bash

current_dir="$(dirname "$0")"

source $current_dir/common.sh
device_name=`get_device_name`

# if (isNexus)
echo "--- Please download the M9 snapshot from this page:"
echo "    https://download.cyanogenmod.org/?device=${device_name}&type=snapshot"
echo
echo "---- Remember to verify the file's provided MD5 checksum against the ouput of this local command:"
echo "     ~$ md5sum path/to/cm-11-20140804-SNAPSHOT-M9-${device_name}.zip"
