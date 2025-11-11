##############################################################################
# RGB Lighting Control
#
# Purpose: Configure OpenRGB for controlling RGB lighting devices
# Features:
#   - OpenRGB support for Lian Li controllers (GA II Trinity, Uni Hub SL Infinity)
#   - Automatic udev rules for non-root device access
#   - Kernel driver unbinding for Lian Li devices
#   - User group permissions for RGB device control
# Notes:
#   - Detected devices: Lian Li GA II Trinity (0416:7373), Uni Hub SL Infinity (0cf2:a102)
#   - Use 'openrgb --list-devices' to see all detected RGB devices
#   - Configure lighting via GUI or save/load profiles with CLI
#   - Lian Li devices unbind from hid-generic driver to allow OpenRGB access
##############################################################################

{ pkgs, ... }:

{
  # ========================================================================
  # Configuration
  # ========================================================================

  # Install OpenRGB
  environment.systemPackages = with pkgs; [
    openrgb
  ];

  # Enable OpenRGB service (sets up udev rules automatically)
  services.hardware.openrgb.enable = true;

  # Add user to openrgb group for device access
  users.users.vee.extraGroups = [ "openrgb" ];

  # Additional udev rules for Lian Li devices not in OpenRGB 0.9
  # Adds device permissions and unbinds from kernel HID driver
  services.udev.extraRules = ''
    # Lian Li GA II Trinity - Add uaccess permission and unbind from hid-generic
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="0416", ATTRS{idProduct}=="7373", TAG+="uaccess", TAG+="Lian_Li_GA_II_Trinity"
    ACTION=="add", SUBSYSTEM=="hid", ATTRS{idVendor}=="0416", ATTRS{idProduct}=="7373", RUN+="${pkgs.bash}/bin/bash -c 'echo $kernel > /sys/bus/hid/drivers/hid-generic/unbind || true'"

    # Lian Li Uni Hub SL Infinity - Add uaccess permission and unbind from hid-generic
    SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="0cf2", ATTRS{idProduct}=="a102", TAG+="uaccess", TAG+="Lian_Li_Uni_Hub_SL_Infinity"
    ACTION=="add", SUBSYSTEM=="hid", ATTRS{idVendor}=="0cf2", ATTRS{idProduct}=="a102", RUN+="${pkgs.bash}/bin/bash -c 'echo $kernel > /sys/bus/hid/drivers/hid-generic/unbind || true'"
  '';
}
