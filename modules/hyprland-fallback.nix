{ inputs, pkgs, ... }:

{
  # Fallback Hyprland Configuration
  # This module provides essential Hyprland packages and settings that may not be
  # included in the dots-hyprland flake. Enable this if you encounter missing packages
  # or if dots-hyprland doesn't provide complete system-level configuration.
  
  # To enable this module, uncomment it in flake.nix
  
  # Enable Hyprland if not already enabled by dots-hyprland
  # programs.hyprland = {
  #   enable = true;
  #   withUWSM = true;
  # };
  
  # Essential environment variables for Hyprland
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  # Essential Hyprland-related packages
  environment.systemPackages = with pkgs; [
    # Core Hyprland utilities (uncomment if needed)
    # pyprland
    # hyprpicker
    
    # Polkit agent (needed for authentication dialogs)
    # lxsession
    
    # Terminal emulators
    # inputs.wezterm.packages.${pkgs.system}.default
    # kitty
    # cool-retro-term
    
    # Shell prompt
    # starship
    
    # Browsers and utilities
    # qutebrowser
    # zathura
    # mpv
    # imv
  ];
}
