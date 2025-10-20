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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.timeout = 2;
  boot.initrd.enable = true;
  boot.initrd.verbose = false;
  boot.initrd.systemd.enable = true;
  boot.consoleLogLevel = 3;
  boot.plymouth = {
    enable = true;
    font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
    # themePackages = [ pkgs.catppuccin-plymouth ];
    # theme = "catppuccin-macchiato";
  };
}
