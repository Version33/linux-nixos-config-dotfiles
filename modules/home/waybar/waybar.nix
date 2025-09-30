{ ... }:

# waybar from https://github.com/Prateek7071/dotfiles/tree/main/waybar
{
  programs.waybar = {
    enable = true;
    style = ./style.css;
  };

  xdg.configFile = {
    "waybar/config" = { source = ./config.jsonc; };
    "waybar/scripts" = { source = ./scripts; };
  };
}