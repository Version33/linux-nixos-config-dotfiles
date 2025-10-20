##############################################################################
# AMD GPU Configuration
#
# Purpose: Configure AMD GPU drivers and overclocking tools
# Features:
#   - amdgpu driver for Xorg and Wayland
#   - GPU overdrive support (overclocking)
#   - LACT for GPU monitoring and configuration
##############################################################################

_:

{
  # Load AMD GPU driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.amdgpu = {
    # https://search.nixos.org/options?channel=unstable&query=hardware.amdgpu
    overdrive.enable = true; # overclocking
  };

  services.lact.enable = true; # LACT: A tool for monitoring, configuring and overclocking GPUs.
}
