{ pkgs, ... }:

let
  hypr-dotfiles = pkgs.fetchFromGitHub {
    owner = "woioeow";
    repo = "hyprland-dotfiles";
    rev = "1547c0f14816d4068e8df06d01a5fa4e148eed86";
    sha256 = "";
  };
in
{
  programs.rofi = {
    enable = true;
    modes = [ "drun" ];
    font = "Jetbrains Mono";
    terminal = "${pkgs.kitty}";
    theme = "${hypr-dotfiles}/hypr_style1/rofi/config.rasi";
  };
}