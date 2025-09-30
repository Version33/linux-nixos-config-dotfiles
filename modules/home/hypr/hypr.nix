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
      package = pkgs.catppuccin-cursors.mochaMauve;
      size = 32;
    };
  };

  services = {
      hyprpaper = {
        enable = true;
        settings = {
          exec-once = "swww init && swww img ${config.home.homeDirectory}/background";
          "misc:disable_hyprland_ipc" = true;
          "animations:first_launch_animation" = false;
        };
      };

      hyprsunset.enable = true;
      hyprpolkitagent.enable = true;
    };
}
