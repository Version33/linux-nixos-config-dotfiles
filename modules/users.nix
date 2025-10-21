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
    ];
    shell = pkgs.nushell;
  };

  programs.firefox.enable = true;
  programs.steam.enable = true;

  # Change runtime directory size
  services.logind.settings.Login = {
    RuntimeDirectorySize = "8G";
  };
}
