##############################################################################
# AMD GPU Configuration
#
# Purpose: Configure AMD GPU drivers and overclocking tools
# Features:
#   - amdgpu driver for Xorg and Wayland
#   - GPU overdrive support (overclocking)
#   - LACT for GPU monitoring and configuration
#   - ROCm support for AI/ML workloads (Ollama, etc.)
##############################################################################

{ pkgs, ... }:

{
  # Load AMD GPU driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.amdgpu = {
    # https://search.nixos.org/options?channel=unstable&query=hardware.amdgpu
    overdrive.enable = true; # overclocking

    # Enable OpenCL (for compute tasks)
    # opencl.enable = true;
  };

  services.lact.enable = true; # LACT: A tool for monitoring, configuring and overclocking GPUs.

  # Add ROCm for AI/ML workloads
  # systemd.tmpfiles.rules = [
  #   "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  # ];

  # # Make ROCm accessible to all users (using hardware.graphics, not deprecated hardware.opengl)
  # hardware.graphics.extraPackages = with pkgs; [
  #   rocmPackages.clr.icd
  #   rocmPackages.clr
  #   rocmPackages.rocm-runtime
  #   libdrm
  # ];
}
