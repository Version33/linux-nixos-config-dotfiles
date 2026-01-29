##############################################################################
# NixOS System Configurations
#
# Purpose: Define NixOS system configurations for all hosts
# Features:
#   - k0or: Main desktop system
##############################################################################

{ inputs, self, ... }:

{
  flake.nixosConfigurations = {
    k0or = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ../configuration.nix
        ../hardware-configuration.nix
        ../modules
      ]
      ++ (builtins.attrValues self.modules.nixos);
    };
  };
}
