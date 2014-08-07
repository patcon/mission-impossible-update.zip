## Get CM11 release

# Check device type via `ro.product.device`
# Examples: mako, flo, etc.

# Note: Whitespace character \r was causing odd formatting.
device_name=$(adb shell getprop ro.product.device | tr -d "\r")
# if (isNexus)
echo "--- Please download the M9 snapshot from this page:"
echo "    https://download.cyanogenmod.org/?device=${device_name}&type=snapshot"
echo
echo "---- Remember to verify the file's provided MD5 checksum against the ouput of this local command:"
echo "     ~$ md5sum path/to/cm-11-20140804-SNAPSHOT-M9-${device_name}.zip"
