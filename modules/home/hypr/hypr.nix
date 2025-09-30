{ pkgs, config, ... }:

{
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
  ];

  home = {
    file = {
      ".config/hypr/hyprland.conf" = { source = ./hyprland.conf; };
      ".config/hypr/monitor.conf" = { source = ./monitor.conf; };
    };

    pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      hyprcursor.enable = true;
      hyprcursor.size = 32;
      name = "Dark";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 32;
    };
  };

  services = {
      hyprpaper = {
        enable = true;
        settings = {
          ipc = "on";
          splash = false;
          preload = [ "~/background" ];
          wallpaper = [
            "DP-2,~/background"     # left
            "DP-3,~/background"     # center
            "HDMI-A-1,~/background" # right
          ];
        };
      };

      hyprsunset.enable = true;
      hyprpolkitagent.enable = true;
    };
}
