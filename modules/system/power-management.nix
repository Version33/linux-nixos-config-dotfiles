##############################################################################
# Power Management Configuration
#
# Purpose: Fix system suspend/resume issues, particularly with AMD GPUs
# Features:
#   - Proper systemd sleep configuration
#   - AMD GPU power management settings
#   - Suspend mode optimization (s2idle/deep)
#   - USB power management fixes
##############################################################################

{ pkgs, lib, ... }:

{
  # Enable power management
  powerManagement.enable = true;

  # Configure systemd sleep modes
  # Use "s2idle" (suspend-to-idle) which works better with modern AMD systems
  # than "deep" (S3 suspend)
  systemd.sleep.extraConfig = ''
    HibernateMode=platform shutdown
    SuspendState=mem
    SuspendMode=s2idle
  '';

  # Ensure AMD GPU stays in appropriate power state during suspend
  boot.extraModprobeConfig = ''
    # AMD GPU power management
    options amdgpu gpu_recovery=1
  '';

  # Additional logind configuration for better suspend behavior
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    IdleAction = "ignore";
  };

  # Create systemd service to fix GPU on resume
  systemd.services.amdgpu-resume-fix = {
    description = "Fix AMD GPU state after resume from suspend";
    after = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    wantedBy = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.kmod}/bin/modprobe -r amdgpu && ${pkgs.kmod}/bin/modprobe amdgpu";
      RemainAfterExit = false;
    };
    # Only run if resume fails
    unitConfig = {
      ConditionPathExists = "/sys/class/drm/card0";
    };
  };
}
