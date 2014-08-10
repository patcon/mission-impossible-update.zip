#!/usr/bin/env bash

current_dir="$(dirname "$0")"

source $current_dir/common.sh
device_name=`get_device_name`

twrp_version="2.7.1.0"
twrp_filename="openrecovery-twrp-${twrp_version}-${device_name}.img"
twrp_download_url="http://techerrata.com/file/twrp2/${device_name}/${twrp_filename}"

twrp_checksum_url="http://techerrata.com/getmd5/twrp2/${device_name}/${twrp_filename}"

cd tmp

echo "--- Downloading Team Win Recovery Project..."
echo "    TWRP Version: ${twrp_version}"
echo "    Device Codename:  ${device_name}"
echo
echo "---- **** WGET OUTPUT ****"
echo
wget --continue --progress=bar ${twrp_download_url}

echo
echo "---- Downloading file checksum..."
wget --continue --quiet --output-document=${twrp_filename}.md5 ${twrp_checksum_url}

echo
echo "---- Verifying file checksum..."
md5sum --check ${twrp_filename}.md5
