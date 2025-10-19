{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.audio-nix.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    bitwig-studio-latest
  ];
}
