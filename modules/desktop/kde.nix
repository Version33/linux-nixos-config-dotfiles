##############################################################################
# KDE Plasma Desktop Environment
#
# Purpose: Configure KDE Plasma 6 desktop with SDDM display manager
# Features:
#   - Plasma 6 desktop environment
#   - SDDM login manager with Wayland support
#   - Essential KDE applications and utilities
##############################################################################

{ pkgs, ... }:

let
  # Fetch the Catppuccin wallpaper
  sddmWallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/minimalistic/romb.png";
    sha256 = "1pdfd0gr718c5ja4apfawl6pa4vi3wga0agf4xmh3c85r4spn8xs";
  };
in
{
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    settings = {
      General = {
        Background = "${sddmWallpaper}";
      };
    };
  };

  # Disable Konsole in favor of Kitty
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
  ];

  # Disable KDE Powerdevil to prevent conflicts with systemd-logind
  systemd.user.services.plasma-powerdevil.enable = false;

  # Configure systemd-logind to handle all power events directly
  services.logind.settings = {
    Login = {
      HandlePowerKey = "suspend";
      HandlePowerKeyLongPress = "poweroff";
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
      IdleAction = "ignore";
    };
  };

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
}
