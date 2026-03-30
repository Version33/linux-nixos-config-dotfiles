{ inputs, ... }:
{
  flake-file.inputs.nvf = {
    url = "github:NotAShelf/nvf";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  perSystem =
    { pkgs, ... }:
    {
      packages.wrapped-neovim =
        (inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            {
              config.vim = {
                viAlias = true;
                vimAlias = true;
              };
            }
          ];
        }).neovim;
    };

  flake.modules.nixos.wrapped-neovim =
    { self, pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.wrapped-neovim
      ];
    };
}
