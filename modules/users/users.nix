##############################################################################
# User Configuration
#
# Purpose: Define system users and user-level applications
# Features:
#   - User 'vee' with nushell as default shell
#   - Member of audio, video, wheel, and realtime groups
#   - Firefox and Steam enabled
#   - 8GB runtime directory size for large tmpfs operations
##############################################################################

{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.vee = {
    isNormalUser = true;
    description = "vee";
    initialPassword = "";
    extraGroups = [
      "networkmanager"
      "input"
      "wheel"
      "video"
      "realtime"
      "audio"
      "tss"
      "plugdev"
    ];
    shell = pkgs.nushell;
  };

  programs.firefox.enable = true;
  programs.steam.enable = true;

  # GameMode for optimizing gaming performance
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
      };
      # Custom scripts can be added here
      # gpu = {
      #   apply_gpu_optimisations = "accept-responsibility";
      #   gpu_device = 0;
      #   amd_performance_level = "high";
      # };
    };
  };

  # Change runtime directory size and power button behavior
  services.logind.settings.Login = {
    RuntimeDirectorySize = "8G";
    HandlePowerKey = "suspend";
  };
}
