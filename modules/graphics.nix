{ pkgs, ... }:

{
  # Enable GPU Acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      mesa
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiVdpau
      mesa
      libvdpau-va-gl
    ];
  };
}
