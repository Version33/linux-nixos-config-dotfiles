{ inputs, ... }:

{

  flake.modules.nixos.nixpkgs = {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    # Add NUR as an overlay so pkgs.nur is available with the correct config
    nixpkgs.overlays = [ inputs.nur.overlays.default ];
  };

}
