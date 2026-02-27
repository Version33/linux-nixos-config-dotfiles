{
  # KDE Plasma configuration
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  flake-file.inputs.plasma-manager = {
    url = "github:nix-community/plasma-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };
  # Define catppuccin here since _theme.nix is disabled but kde.nix uses the package
  # System-wide theming
  flake-file.inputs.catppuccin.url = "github:catppuccin/nix";

  # Home Manager NixOS integration — wires all flake.modules.homeManager.* into user "vee"
  flake.modules.nixos.home-manager =
    { inputs, self, ... }:
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ];
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.sharedModules = [
        inputs.plasma-manager.homeModules.plasma-manager
        inputs.catppuccin.homeModules.catppuccin
      ];
      home-manager.users.vee =
        { ... }:
        {
          imports = builtins.attrValues self.modules.homeManager;
          home.stateVersion = "25.05";
        };
    };

  flake.modules.nixos.kde =
    { pkgs, ... }:
    let
      # Fetch the Catppuccin wallpaper for SDDM
      sddmWallpaper = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/minimalistic/romb.png";
        sha256 = "1pdfd0gr718c5ja4apfawl6pa4vi3wga0agf4xmh3c85r4spn8xs";
      };
    in
    {
      services = {
        desktopManager.plasma6.enable = true;
        displayManager.sddm = {
          enable = true;
          settings = {
            General = {
              Background = "${sddmWallpaper}";
            };
          };
        };

        # Configure systemd-logind to handle all power events directly
        logind.settings = {
          Login = {
            HandlePowerKey = "suspend";
            HandlePowerKeyLongPress = "poweroff";
            HandleLidSwitch = "suspend";
            HandleLidSwitchExternalPower = "suspend";
            IdleAction = "ignore";
          };
        };
      };

      # Disable Konsole in favor of Kitty
      environment.plasma6.excludePackages = with pkgs.kdePackages; [
        konsole
      ];

      # Disable KDE Powerdevil to prevent conflicts with systemd-logind
      systemd.user.services.plasma-powerdevil.enable = false;

      environment.systemPackages = with pkgs; [
        # KDE
        # kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
        kdePackages.kcalc # Calculator
        kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
        kdePackages.kclock # Clock app
        kdePackages.kcolorchooser # A small utility to select a color
        kdePackages.kolourpaint # Easy-to-use paint program
        kdePackages.ksystemlog # KDE SystemLog Application
        kdePackages.sddm-kcm # Configuration module for SDDM
        kdiff3 # Compares and merges 2 or 3 files or directories
        kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
        kdePackages.partitionmanager # Optional: Manage the disk devices, partitions and file systems on your computer
        # Theme
        catppuccin-cursors.mochaDark # Catppuccin cursor theme
        catppuccin-kde # Catppuccin theme for KDE Plasma
        catppuccin-papirus-folders # Papirus-Dark icon theme with Catppuccin folder colors (needed system-wide for system tray icons)
        # Non-KDE graphical packages
        hardinfo2 # System information and benchmarks for Linux systems
        vlc # Cross-platform media player and streaming server
        wayland-utils # Wayland utilities
        wl-clipboard # Command-line copy/paste utilities for Wayland
      ];
    };

  # ============================================================================
  # Home Manager - Plasma Configuration
  # ============================================================================

  flake.modules.homeManager.plasma =
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
      #   wallpaper2 = pkgs.fetchurl {
      #     url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/minimalistic/tetris.png";
      #     sha256 = "16dfxxn77fymb44daadd85ck0l98zvmyq6lg9l04ip0dsirzmxkc";
      #   };
    in
    {
      # Configure Plasma using plasma-manager

      # Enable Catppuccin theme for applications
      catppuccin = {
        enable = true;
        flavor = "mocha";
        kvantum.enable = true;
      };

      # Configure Qt to use Kvantum
      qt = {
        enable = true;
        platformTheme.name = "kvantum";
        style.name = "kvantum";
      };

      home.packages = with pkgs; [
        catppuccin-cursors.mochaDark
        (catppuccin-kde.override {
          flavour = [ "mocha" ];
          accents = [ "blue" ];
        })
        kdePackages.qtstyleplugin-kvantum
      ];

      programs.plasma = {
        enable = true;

        workspace = {
          # Note: Not using lookAndFeel to avoid conflicts with manual windowDecorations override
          # Instead, setting individual theme components that would be part of Catppuccin-Mocha-Blue

          # Set Catppuccin Mocha color scheme
          colorScheme = "CatppuccinMochaBlue";

          # Use Papirus Dark icons
          iconTheme = "Papirus-Dark";

          cursor = {
            theme = "catppuccin-mocha-dark-cursors";
            size = 24;
          };

          # Override window decorations to use Breeze (instead of Catppuccin theme default)
          windowDecorations = {
            library = "org.kde.breeze";
            theme = "Breeze";
          };

          # Set wallpapers per monitor (wallpaper array is ordered by monitor priority, not screen number)
          # To re-enable right monitor: add "wallpaper2" to array below and uncomment HDMI-A-1 priority line
          wallpaper = [
            wallpaper1 # Priority 1
            wallpaper0 # Priority 2
            # wallpaper2  # Priority 3
          ];
        };

        # Configure panel with 24-hour clock
        panels = [
          # Main monitor panel (DP-3, priority 2)
          {
            location = "bottom";
            screen = 0;
            widgets = [
              "org.kde.plasma.kickoff"
              {
                iconTasks = {
                  launchers = [
                    "applications:kitty.desktop"
                    "applications:org.kde.dolphin.desktop"
                    "applications:vesktop.desktop"
                    "preferred://browser"
                    "applications:codium.desktop"
                    "applications:steam.desktop"
                  ];
                };
              }
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
          # Secondary monitor panel (DP-2, priority 1)
          {
            location = "bottom";
            screen = 1;
            widgets = [
              "org.kde.plasma.kickoff"
              {
                iconTasks = {
                  launchers = [
                    "applications:kitty.desktop"
                    "applications:org.kde.dolphin.desktop"
                    "applications:vesktop.desktop"
                    "preferred://browser"
                    "applications:codium.desktop"
                    "applications:steam.desktop"
                  ];
                };
              }
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

        configFile = {
          # Disable edge barriers (sticky screen edges) between monitors
          "kwinrc"."EdgeBarrier"."EdgeBarrier" = 0;

          "plasma-localerc"."Formats" = {
            LANG = "en_US.UTF-8";
            LC_TIME = "C.UTF-8";
            useDetailed = true;
          };

          # Set default terminal to Kitty
          "kdeglobals"."General"."TerminalApplication" = "kitty";
          "kdeglobals"."General"."TerminalService" = "kitty.desktop";

          # Set lockscreen wallpaper
          "kscreenlockerrc"."Greeter"."WallpaperPlugin" = "org.kde.image";
          "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."Image" = "${wallpaper1}";

        };
      };
    };
}
