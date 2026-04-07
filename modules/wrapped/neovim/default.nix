{ inputs, self, ... }:
{
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
          modules = builtins.attrValues self.modules.neovim;
        }).neovim;
    };

  # System: auto-imported via flake.modules.nixos
  flake.modules.nixos.wrapped-neovim =
    { self, pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.wrapped-neovim
      ];
    };
}
