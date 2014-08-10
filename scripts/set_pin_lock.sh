#!/usr/bin/env bash

current_dir="$(dirname "$0")"

source $current_dir/common.sh

connect_adb
adb shell su -c "am start -n com.android.settings/com.android.settings.ChooseLockPassword"
