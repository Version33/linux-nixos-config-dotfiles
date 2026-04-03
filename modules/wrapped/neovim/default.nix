{
  inputs,
  lib,
  config,
  ...
}:
{
  # Accumulated by each sibling module (options.nix, theme.nix, …)
  options.neovimModules = lib.mkOption {
    type = lib.types.listOf lib.types.raw;
    default = [ ];
    description = "nvf modules assembled into wrapped-neovim";
  };

  config = {
    flake-file.inputs.nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Standalone: nix run .#wrapped-neovim
    perSystem =
      { pkgs, ... }:
      {
        packages.wrapped-neovim =
          (inputs.nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = config.neovimModules;
          }).neovim;
      };

    # System: add this flake's nixosModules.wrapped-neovim to your NixOS imports
    flake.nixosModules.wrapped-neovim =
      { self, pkgs, ... }:
      {
        environment.systemPackages = [
          self.packages.${pkgs.stdenv.hostPlatform.system}.wrapped-neovim
        ];
      };
  };
}
