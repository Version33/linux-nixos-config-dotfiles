##############################################################################
# Orca Slicer Nightly Build Support
#
# This module enables running OrcaSlicer nightly builds via AppImage.
# Nightly builds include the latest features like H2D/H2S printer support.
#
# Usage:
#   1. Download the latest nightly AppImage from:
#      https://github.com/SoftFever/OrcaSlicer/releases/tag/nightly-builds
#   2. Run with: appimage-run ~/Downloads/OrcaSlicer*.AppImage
#   3. Or make it executable and run directly (binfmt enabled)
#
# For H2D printer support:
#   - Enable both LAN mode AND developer mode on your H2D printer
#   - Turn off "Use legacy network plugin" in Orca's preferences
##############################################################################

{ pkgs, ... }:

{
  # Enable AppImage support system-wide
  programs.appimage = {
    enable = true;
    binfmt = true;  # Allows running AppImages directly
  };

  # Install appimage-run for manual AppImage execution
  environment.systemPackages = with pkgs; [
    appimage-run
  ];
}
