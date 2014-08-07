#!/usr/bin/env bash

BASEDIR=$(dirname $0)

# Only diff from article is Orbot v14.0.4.1 instead of v13.0.7
apk_files=( \
  org.torproject.android_109.apk # v14.0.4.1 \
  com.googlecode.droidwall_157.apk \
  com.xabber.androiddev_81.apk \
  org.sufficientlysecure.localcalendar_6.apk \
  org.linphone_2120.apk \
  com.morlunk.mumbleclient_67.apk \
  com.fsck.k9_20005.apk \
  org.thialfihar.android.apg_11199.apk \
  net.osmand.plus_182.apk \
  org.videolan.vlc_9714.apk \
  fennec-31.0.multi.android-arm.apk \
  de.schildbach.wallet_173.apk \
  com.adstrosoftware.launchappops_1.apk \
  com.FireFart.Permissions2_3.apk \
  com.nolanlawson.logcat_41.apk \
  com.eolwral.osmonitor_54.apk \
  uk.co.ashtonbrsc.android.intentintercept_204.apk \
)

echo "--- Downloading F-Droid app market APK..."
cd ${BASEDIR}/system/app
wget --no-verbose --continue https://f-droid.org/repo/org.fdroid.fdroid_710.apk

echo "--- Downloading ${#apk_files[@]} F-Droid packages..."
echo "    This is parallel, but may still take awhile."
echo "    (Partially-downloaded files will be resumed.)"

cd ${BASEDIR}/data/app
printf "%s\n" "${apk_files[@]}" \
  | xargs --max-args=1 --max-procs=8 -i \
    wget --no-verbose --continue https://f-droid.org/repo/{}

echo "--- All package downloaded!"
