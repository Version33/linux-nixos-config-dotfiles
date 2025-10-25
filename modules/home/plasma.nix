{ pkgs, ... }:

let
  # Fetch the Catppuccin wallpaper for left monitor
  wallpaper0 = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/misc/cat-sound.png";
    sha256 = "1ypxz7nnz11x9j7ndrv78ics0x60vymrvzf2in9rhv3ywd3wjbaw";
  };

  # Fetch the Catppuccin wallpaper for center monitor
  wallpaper1 = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/landscapes/tropic_island_night.jpg";
    sha256 = "0p296jiyc59ax99b2n2430c2j8h5ja1fxjzhf3m42v623v938vqn";
  };

  # Fetch the Catppuccin wallpaper for right monitor (disabled - monitor dead, keeping for future replacement)
  wallpaper2 = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/minimalistic/tetris.png";
    sha256 = "16dfxxn77fymb44daadd85ck0l98zvmyq6lg9l04ip0dsirzmxkc";
  };
in
{
  # Configure Plasma using plasma-manager

  # Enable Catppuccin theme for Plasma
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  home.packages = with pkgs; [
    catppuccin-kde
    catppuccin-cursors.mochaDark
    catppuccin-papirus-folders
  ];

  programs.plasma = {
    enable = true;

    workspace = {
      # Set to Catppuccin Mocha theme
      colorScheme = "CatppuccinMocha";

      # Use Papirus Dark icons
      iconTheme = "Papirus-Dark";

      # Set cursor theme
      cursor = {
        theme = "catppuccin-mocha-dark-cursors";
      };

      # Set wallpapers per monitor (wallpaper array is ordered by monitor priority, not screen number)
      # To re-enable right monitor: add "wallpaper2" to array below and uncomment HDMI-A-1 priority line
      wallpaper = [
        wallpaper0  # Priority 1: DP-3 (center, PRIMARY) - Plasma screen 1
        wallpaper1  # Priority 2: DP-2 (left) - Plasma screen 0
        # wallpaper2  # Priority 3: HDMI-A-1 (right, DEAD) - would be Plasma screen 2
      ];
    };

    # Configure panel with 24-hour clock
    panels = [
      {
        location = "bottom";
        screen = 0;  # Plasma screen 1 = DP-3 (center monitor, primary)
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          {
            digitalClock = {
              time = {
                format = "24h";
                showSeconds = "onlyInTooltip";
              };
              date = {
                enable = true;
                format = "isoDate";
              };
            };
          }
        ];
      }
    ];

    # Configure locale for 24-hour time
    configFile = {
      "plasma-localerc"."Formats" = {
        LANG = "en_US.UTF-8";
        LC_TIME = "C.UTF-8";
        useDetailed = true;
      };

      # Explicit screen/monitor configuration
      # Based on kscreen-doctor output:
      # - DP-3 (DEL D22...) = center monitor (PRIMARY - priority 1)
      # - DP-2 (SPT DP...) = left monitor (priority 2)
      # - HDMI-A-1 (HPN HP...) = right monitor (DEAD - uncomment when replaced)
      "kscreenrc"."DP-3"."priority" = 2;  # Primary/center monitor
      "kscreenrc"."DP-2"."priority" = 1;
      # "kscreenrc"."HDMI-A-1"."priority" = 3;  # Uncomment when right monitor is replaced
    };
  };
}
