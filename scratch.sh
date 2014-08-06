#!/usr/bin/env bash

## CHECK SOFTWARE

which fastboot
which adb
which wget

### VERIFY HARDWARE

# Link: https://trac.torproject.org/projects/tor/wiki/doc/HardeningAndroid#HardwareSelection

# TODO: warn if using hardware with baseband

# Ref: http://www.antutu.com/view.shtml?id=7314
# apq = Application Processor only without baseband processor
# mdm = Modem Data Mover, part of Mobile Station Modem (MSM) chipset
# We should check this.
# ro.baseband is also a thing, and should theoretically be identical (?)
baseband_version=`adb shell getprop gsm.version.baseband`
echo $baseband_version
echo

# if (baseband_version)
#   # warn that baseband isn't isolated (ie. not wifi)

# This might be more useful: gsm.version.baseband
# Seems to have meaningful versions in everything with baseband.
# See: https://guardianproject.info/wiki/Android_getprop_collection
# Perhaps it's "unknown" in wifi-only devices.
# NOTE: value doesn't exist on Nexus 7 wifi :)

## Get CM11 release

# Check device type via `ro.product.device`
# Examples: mako, flo, etc.

# Note: Whitespace character \r was causing odd formatting.
device_name=$(adb shell getprop ro.product.device | tr -d "\r")
# if (isNexus)
echo "--- Please download the M6 snapshot from this page:"
echo "    https://download.cyanogenmod.org/?device=${device_name}&type=snapshot"

## Get TWRP

twrp_version="2.7.0.0"
twrp_download_url="http://techerrata.com/file/twrp2/${device_name}/openrecovery-twrp-${twrp_version}-${device_name}.img"

echo "--- Downloading Team Win Recovery Project..."
echo "    TWRP Version: ${twrp_version}"
echo "    Device Codename:  ${device_name}"
echo
echo "---- **** WGET OUTPUT ****"
echo
wget --continue --progress=bar ${twrp_download_url}

## RESTART PHONE IN BOOT

# confirm adb works
adb devices

# restart in bootloader
adb reboot bootloader

# confirm fastboot mode works
fastboot devices # should list device
# else, might need elevated perms
sudo fastboot devices

# unlock bootloader
fastboot oem unlock

# flash recovery drive
fastboot flash recovery openrecovery-twrp-${twrp_version}-${device_name}.img

# DEVICE: Boot into recovery. Enter encryption password if required.

# DEVICE: Wipe > Advanced Wipe > Check all except "usb-otg"

# DEVICE: Wipe > Format Data > Type "yes"

adb server start
adb push cm-11-20140504-SNAPSHOT-M6-flo.zip /sdcard/
# Ask whether want to install Google Apps:
adb push gapps-kk-20140105-signed.zip /sdcard/

# DEVICE: Install > CM-11 file > Add More Zips > Gapps > Check "Zip file signature verification" > Swipe to Confirm Flash

# Disable Setup wizard: (doesn't work..)
adb shell setprop ro.setupwizard.mode DISABLE

# turn on airplane mode
# See: http://stackoverflow.com/a/23413344/504018
adb shell am start -a android.settings.AIRPLANE_MODE_SETTINGS # open settings
adb shell input keyevent KEYCODE_ENTER # highlight airplane mode
adb shell input keyevent KEYCODE_ENTER # enable airplane mode
adb shell input keyevent KEYCODE_BACK # exit settings

# DEVICE:
# - Skip account creations

# Add PIN: bring PIN choice screen up on device:
su root am start -n com.android.settings/com.android.settings.ChooseLockPassword
