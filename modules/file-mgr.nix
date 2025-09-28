{ pkgs, ... }:

{
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    xfconf.enable = true;
    file-roller.enable = true;
    dconf.enable = true;
  };
  services = {
    gvfs.enable = true;
    tumbler.enable = true;
  };
  environment.systemPackages = with pkgs; [
    xdg-utils
  ];
}
