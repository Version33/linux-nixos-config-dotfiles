{ ... }:

{
  # udev rule for:
  # Ableton Push 3 USB premission
  # Audient Evo 8
  services.udev.extraRules = ''
    		SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="2982", ENV{ID_MODEL_ID}=="1969", MODE="0660", GROUP="audio"
        SUBSYSTEM=="usb", ATTR{idVendor}=="2708", ATTR{idProduct}=="0007", MODE="0666", GROUP="audio"
    	'';
}
