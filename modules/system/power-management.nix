##############################################################################
# Power Management Configuration
#
# Purpose: Fix system suspend/resume issues, particularly with AMD GPUs
# Features:
#   - Kernel parameter to force s2idle mode for AMD compatibility
#   - AMD GPU power management options for better suspend/resume
#   - Proper logind idle action configuration
# 
# References:
#   - systemd-sleep.conf(5): Sleep configuration options
#   - /sys/power/mem_sleep: Available sleep modes (s2idle, deep)
#   - amdgpu kernel params: gpu_recovery, ppfeaturemask, dc
#   - Arch Wiki: Power management/Suspend and hibernate
##############################################################################

{ pkgs, lib, ... }:

{
  # Enable power management
  powerManagement.enable = true;

  # Force s2idle mode via kernel parameter (most reliable method for AMD)
  boot.kernelParams = [
    "mem_sleep_default=s2idle"
  ];

  # AMD GPU power management options for better suspend/resume
  boot.extraModprobeConfig = ''
    # AMD GPU power management - enable recovery after failed suspend/resume
    options amdgpu gpu_recovery=1
    
    # Enable display core for better power management
    options amdgpu dc=1
    
    # Enable all power play features
    options amdgpu ppfeaturemask=0xffffffff
  '';

  # Additional logind configuration for suspend/resume
  # Note: HandlePowerKey and RuntimeDirectorySize configured in modules/users/users.nix
  services.logind.settings.Login = {
    IdleAction = "ignore";
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";
  };
}
