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
  programs.waybar = {
    enable = true;
    # style = "${hypr-dotfiles}/hypr_style1/waybar/style.css";
  };

  xdg.configFile."waybar/config" = {
    source = "${hypr-dotfiles}/hypr_style1/waybar";
  };
}