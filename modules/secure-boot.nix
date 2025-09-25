{ pkgs, lib, ... }:
let
  lanzaboote = {
    url = "github:nix-community/lanzaboote/v0.4.2";
    inputs.nixpkgs.follows = "nixpkgs";
  };
in
{
  imports = [ lanzaboote.nixosModules.lanzaboote ];

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