{ ... }:
{
  # KDE Plasma configuration
  flake-file.inputs.plasma-manager = {
    url = "github:nix-community/plasma-manager";
    inputs.home-manager.follows = "home-manager";
  };
  # Define catppuccin here since _theme.nix is disabled but kde.nix uses the package
  # System-wide theming
  flake-file.inputs.catppuccin.url = "github:catppuccin/nix";

  flake.modules.nixos.kde =
    { pkgs, ... }:
    let
      # Fetch the Catppuccin wallpaper
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
        catppuccin-kde # Catppuccin theme for KDE Plasma
        # Non-KDE graphical packages
        hardinfo2 # System information and benchmarks for Linux systems
        vlc # Cross-platform media player and streaming server
        wayland-utils # Wayland utilities
        wl-clipboard # Command-line copy/paste utilities for Wayland
      ];
    };

}
