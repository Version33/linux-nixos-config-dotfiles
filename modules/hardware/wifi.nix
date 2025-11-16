{ pkgs, ... }:

{
  # Disable WiFi hardware (MediaTek MT7925e)
  # This blacklists the WiFi driver while keeping Bluetooth functional
  # The mt7925e chip has separate modules for WiFi and Bluetooth
  boot.blacklistedKernelModules = [
    "mt7925e" # MediaTek MT7925 WiFi driver
  ];
}
