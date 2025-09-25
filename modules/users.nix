{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vee = {
    isNormalUser = true;
    description = "vee";
    extraGroups = [ "networkmanager" "input" "wheel" "video" "realtime" "audio" "tss" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      tidal-hifi
      discord
      vscodium
      firefox
    ];
  };

  # Change runtime directory size
  services.logind.settings.Login = {
    RuntimeDirectorySize="8G";
  };
}
