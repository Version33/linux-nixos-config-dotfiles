{ ... }:

{
  # udev rule for Ableton Push 3 USB premission
	services.udev.extraRules = ''
		SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="2982", ENV{ID_MODEL_ID}=="1969", MODE="0660", GROUP="audio"
	'';
}