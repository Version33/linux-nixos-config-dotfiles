{ pkgs, ... }:
# probably unneeded for a desktop
{
  programs.light.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}
