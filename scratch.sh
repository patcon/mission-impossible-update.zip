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

# DEVICE:
# - Skip account creations

# SCRATCH: Copy fresh appops.xml from device to set initial privacy guard perms:
# /data/system/appops.xml

# SCRATCH: Setting launcher apps happens in this db:
# /data/data/com.cyanogenmod.trebuchet/databases/launcher.db

# Add guardian project f-droid repo: https://guardianproject.info/2012/03/15/our-new-f-droid-app-repository/
