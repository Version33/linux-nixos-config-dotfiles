{ pkgs, ... }:

{
  # Enable GPU Acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      # libvdpau-va-gl # Removed: has CMake compatibility issues with current nixpkgs
      mesa
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiVdpau
      mesa
      # libvdpau-va-gl # Removed: has CMake compatibility issues with current nixpkgs
    ];
  };
}
