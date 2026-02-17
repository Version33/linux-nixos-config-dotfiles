{ inputs, self, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.flake-file.flakeModules.default
  ];

  # Configure flake-file
  flake-file.outputs = "inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules)";

  # Define core flake inputs here
  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Core system packages
    flake-parts.url = "github:hercules-ci/flake-parts"; # Module system for flakes
    import-tree.url = "github:vic/import-tree"; # Automatic module discovery

    # Program wrappers
    wrappers.url = "github:Lassulus/wrappers"; # Simple wrapper library

    # Boilerplate reduction tools
    flake-file.url = "github:vic/flake-file"; # Generates flake.nix from modules
    nix-auto-follow.url = "github:fzakaria/nix-auto-follow"; # Fixes input version duplications
    treefmt-nix.url = "github:numtide/treefmt-nix"; # Project-wide formatting (used by dev.nix)
  };

  # System architectures this flake supports
  systems = [ "x86_64-linux" ];

  # NixOS system configurations
  flake.nixosConfigurations = {
    k0or = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs self;
      };
      modules = [
        ../hardware-configuration.nix
      ]
      # Load all dendritic NixOS modules
      ++ (builtins.attrValues self.modules.nixos);
    };
  };

}
