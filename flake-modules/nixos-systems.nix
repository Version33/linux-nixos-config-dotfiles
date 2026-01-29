{ inputs, self, ... }:

{
  flake.nixosConfigurations = {
    k0or = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs self;
      };
      modules = [
        ../configuration.nix
        ../hardware-configuration.nix
        ../modules

        # Home Manager integration (following vic's pattern)
        # See: https://github.com/vic/vix/blob/main/modules/vic/home.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
          # Load all dendritic home-manager modules
          home-manager.sharedModules = builtins.attrValues (self.modules.homeManager or { });
        }
      ]
      # Load all dendritic NixOS modules
      ++ (builtins.attrValues self.modules.nixos);
    };
  };
}
