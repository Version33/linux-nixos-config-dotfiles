##############################################################################
# Power Management Configuration
#
# Purpose: Fix system suspend/resume issues, particularly with AMD GPUs
# Features:
#   - Systemd sleep configuration using s2idle mode for AMD compatibility
#   - AMD GPU power management via kernel parameters (see boot/linux-kernel.nix)
#   - Proper logind idle action configuration
# 
# References:
#   - systemd-sleep.conf(5): Sleep configuration options
#   - /sys/power/mem_sleep: Available sleep modes (s2idle, deep)
#   - amdgpu kernel params: gpu_recovery, ppfeaturemask
##############################################################################

{ pkgs, lib, ... }:

{
  # Enable power management
  powerManagement.enable = true;

  # Configure systemd sleep modes
  # Use "s2idle" (suspend-to-idle) which works better with modern AMD systems
  # than "deep" (S3 suspend). This is written to /sys/power/mem_sleep.
  systemd.sleep.extraConfig = ''
    HibernateMode=platform shutdown
    SuspendState=mem
    MemorySleepMode=s2idle
  '';

  # Ensure AMD GPU stays in appropriate power state during suspend
  # This duplicates the setting from boot/linux-kernel.nix but also sets
  # it as a modprobe option for consistency
  boot.extraModprobeConfig = ''
    # AMD GPU power management - enable recovery after failed suspend/resume
    options amdgpu gpu_recovery=1
  '';

  # Additional logind configuration
  # Note: HandlePowerKey is already configured in modules/users/users.nix
  services.logind.settings.Login = {
    IdleAction = "ignore"; # Don't auto-suspend on idle
  };
}
