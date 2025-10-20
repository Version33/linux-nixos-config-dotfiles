##############################################################################
# Secure Boot Configuration
#
# Purpose: Enable UEFI Secure Boot using Lanzaboote
# Features:
#   - Lanzaboote bootloader with Secure Boot support
#   - sbctl for managing Secure Boot keys
#   - Automatic kernel signing
# Note: Requires initial setup with sbctl to create and enroll keys
##############################################################################

{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  environment.systemPackages = [
    pkgs.sbctl # For debugging and troubleshooting Secure Boot.
  ];

  # Lanzaboote requires disabling the default systemd-boot loader
  boot.loader.systemd-boot.enable = lib.mkForce false;

  # Enable and configure Lanzaboote
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
