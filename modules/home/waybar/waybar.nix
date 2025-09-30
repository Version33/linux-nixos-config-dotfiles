{ ... }:

# waybar config from https://github.com/gaurav23b/simple-hyprland/tree/main/configs/waybar
{
  programs.waybar.enable = true; 

  home.file = {
    ".config/waybar/config.jsonc" = { source = ./config.jsonc; };
    ".config/waybar/style.css" = { source = ./style.css; };
  };
}
