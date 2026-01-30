{ inputs, self, ... }:
{
  # Import flake-parts modules support
  imports = [ inputs.flake-parts.flakeModules.modules ];

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

  # Development environment
  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.nixfmt;

      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          # Nix development tools
          nixd # Nix language server
          nixfmt # Nix formatter (RFC 166 style)
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
