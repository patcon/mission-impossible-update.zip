#!/usr/bin/env bash

current_dir="$(dirname "$0")"

source $current_dir/common.sh

# read password twice
read -s -p "Password: " password
echo
read -s -p "Password (again): " password2

# check if passwords match and if not ask again
while [ "$password" != "$password2" ];
do
    echo
    echo
    echo "Please try again"
    read -s -p "Password: " password
    echo
    read -s -p "Password (again): " password2
done

echo

connect_adb
adb shell su -c "vdc cryptfs enablecrypto inplace '$password'"
