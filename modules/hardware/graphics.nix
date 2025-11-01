##############################################################################
# Graphics Configuration
#
# Purpose: Enable GPU hardware acceleration for graphics and video
# Features:
#   - OpenGL/Vulkan acceleration
#   - 32-bit support for compatibility (gaming, Wine)
#   - VA-API and VDPAU video acceleration
##############################################################################

{ pkgs, ... }:

{
  # Enable GPU Acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libvdpau-va-gl
      mesa
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa
      libvdpau-va-gl
    ];
  };
}
