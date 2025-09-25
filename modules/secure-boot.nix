{ pkgs, lib, ... }:

{
  # This module assumes that the main lanzaboote module has already been
  # imported into your NixOS configuration.

  # Add sbctl to system packages for key management
  environment.systemPackages = [
    pkgs.sbctl
  ];

  # Lanzaboote requires disabling the default systemd-boot loader
  boot.loader.systemd-boot.enable = lib.mkForce false;

  # Enable and configure Lanzaboote
  boot.lanzaboote = {
    enable = true;
    # This points to the location where sbctl stores the Secure Boot keys
    pkiBundle = "/var/lib/sbctl";
  };
}