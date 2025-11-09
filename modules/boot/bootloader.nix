##############################################################################
# Bootloader Configuration
#
# Purpose: Configure systemd-boot bootloader with Plymouth boot splash
# Features:
#   - systemd-boot for UEFI systems
#   - Plymouth splash screen
#   - Reduced boot verbosity for clean boot experience
#   - 2-second boot menu timeout
##############################################################################

{ pkgs, ... }:

{
  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      timeout = 2;
    };
    initrd = {
      enable = true;
      verbose = false;
      systemd.enable = true;
    };
    consoleLogLevel = 3;
    plymouth = {
      enable = true;
      font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
      # themePackages = [ pkgs.catppuccin-plymouth ];
      # theme = "catppuccin-macchiato";
    };
  };
}
