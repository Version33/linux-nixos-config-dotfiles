{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [ inputs.audio.overlays.default ];
  environment.systemPackages = with pkgs; [
    bitwig-studio-latest
  ];
}