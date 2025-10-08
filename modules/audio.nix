{ pkgs, inputs, ... }:

{
  # imports = [
  #   inputs.audio-nix.nixosModules.yabridgemgr
  # ];

  nixpkgs.overlays = [
    inputs.audio-nix.overlays.default
  ];

  # Configure the module using the correct path
  # modules.audio-nix.yabridgemgr = {
  #   enable = true;
  #   user = "vee";

  #   plugins = with inputs.audio-nix.packages.${pkgs.system}; [
  #     wine-valhalla
  #   ];
  # };

  environment.systemPackages = with pkgs; [
    bitwig-studio
  ];
}
