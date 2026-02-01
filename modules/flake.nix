{ inputs, self, ... }:
{
  # Import flake-parts modules and tools
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.flake-file.flakeModules.default
    inputs.treefmt-nix.flakeModule
  ];

  # Configure flake-file
  flake-file.outputs = "inputs: import ./. inputs";

  # Define core flake inputs here
  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Core system packages
    home-manager.url = "github:nix-community/home-manager"; # User environment manager
    flake-parts.url = "github:hercules-ci/flake-parts"; # Module system for flakes
    import-tree.url = "github:vic/import-tree"; # Automatic module discovery

    # Audio production tools
    audio-nix.url = "github:polygon/audio.nix"; # Bitwig and other audio packages

    # Boilerplate reduction tools
    flake-file.url = "github:vic/flake-file"; # Generates flake.nix from modules
    nix-auto-follow.url = "github:fzakaria/nix-auto-follow"; # Fixes input version duplications
    treefmt-nix.url = "github:numtide/treefmt-nix"; # Project-wide formatting
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

        # Home Manager integration
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

  # Development environment & formatting
  perSystem =
    { pkgs, ... }:
    {
      # Configure treefmt
      treefmt = {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
        programs.nixfmt.package = pkgs.nixfmt;
      };

      # Development Shell
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          # Nix development tools
          nixd # Nix language server
          nixfmt # Nix formatter
          statix # Lints and suggestions for Nix code
          deadnix # Find and remove unused code
          nix-tree # Visualize dependency tree
          nix-output-monitor # Better build output (alias: nom)

          # Development environment tools
          direnv # Automatic environment activation
          nix-direnv # Fast direnv integration for Nix

          # Useful utilities
          git
          just # Command runner (for justfile)
        ];
      };
    };
}
