{ ... }:
{

  flake.modules.nixos.nixpkgs =
    { pkgs, ... }:
    {
      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;
    };

}
