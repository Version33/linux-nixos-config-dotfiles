##############################################################################
# NixOS System Configurations
#
# Purpose: Define NixOS system configurations for all hosts
# Features:
#   - k0or: Main desktop system
##############################################################################

{ inputs, ... }:

{
  flake.nixosConfigurations = {
    k0or = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        inputs.nix-flatpak.nixosModules.nix-flatpak
        ../configuration.nix
        ../hardware-configuration.nix
        ../modules
      ];
    };
  };
}
