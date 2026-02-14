{

  flake.modules.nixos.udev = {
    services.udev.extraRules = ''
      # Ableton Push 3
      SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="2982", ENV{ID_MODEL_ID}=="1969", MODE="0660", GROUP="audio"

      # Audient Evo 8
      SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="2708", ENV{ID_MODEL_ID}=="0007", MODE="0666", GROUP="audio"

      # WebUSB access for plugdev group members
      # TAG+="uaccess" grants logged-in users access via systemd-logind
      SUBSYSTEM=="usb", MODE="0664", GROUP="plugdev", TAG+="uaccess"
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0664", GROUP="plugdev", TAG+="uaccess"
    '';

    # Create plugdev group for WebUSB access
    users.groups.plugdev = { };
  };

}
