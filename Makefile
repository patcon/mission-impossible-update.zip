cm_dl_link:
	scripts/cyanogenmod_download_link.sh

dl_twrp:
	mkdir -p tmp
	scripts/download_twrp.sh

download_apks:
	mkdir -p data/app
	mkdir -p system/app
	./download_apks.sh

package:
	mkdir -p build
	zip -r build/mission-impossible-update.zip *

goto_fastboot:
	adb reboot-bootloader

push:
	adb push build/mission-impossible-update.zip /sdcard/

set_pin_lock:
	scripts/set_pin_lock.sh

encrypt_device:
	scripts/encrypt_device.sh
