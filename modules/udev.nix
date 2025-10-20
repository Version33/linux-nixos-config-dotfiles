_:

{
  # udev rule for:
  # Ableton Push 3 USB premission
  # Audient Evo 8
  services.udev.extraRules = ''
    		SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="2982", ENV{ID_MODEL_ID}=="1969", MODE="0660", GROUP="audio"
        SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="2708", ENV{ID_MODEL_ID}=="0007", MODE="0666", GROUP="audio"
    	'';
}
