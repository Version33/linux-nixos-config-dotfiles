{ pkgs, ... }:

{
  services.udev.packages = [ ]; # removed `pkgs.yubikey-personalization` find solokey version (if that's even needed)

  programs.ssh.startAgent = true;

  # FIXME Don't forget to create an authorization mapping file for your user (https://nixos.wiki/wiki/Yubikey#pam_u2f)
  # TODO I don't use yubikey, I have a SoloKey 2, so refactor this module to use solo2-cli
  # will need to look into that
  security.pam.u2f = {
    enable = true;
    settings.cue = true;
    control = "sufficient";
  };

  security.pam.services = {
    greetd.u2fAuth = true;
    sudo-rs.u2fAuth = true;
    hyprlock.u2fAuth = true;
  };

  environment.systemPackages = with pkgs; [
    hello
  ];
}
