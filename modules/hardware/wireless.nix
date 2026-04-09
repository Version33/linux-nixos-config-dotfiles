{

  flake.modules.nixos.wireless = {
    hardware = {
      # Firmware required for MediaTek MT7925 WiFi/BT chip
      enableRedistributableFirmware = true;

      # Enable Bluetooth
      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;
    };
  };

}
