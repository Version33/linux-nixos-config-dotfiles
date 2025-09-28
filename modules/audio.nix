{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.audio-nix.overlays.default
  ];
  modules.audio-nix.yabridgemgr = {
    enable = true;
    user = "vee";

    plugins = with inputs.audio-nix.packages.${pkgs.system}; [
      wine-valhalla
      # (pkgs.callPackage ./plugins/serum2.nix { })
    ];
  };
  # systemd.user.services.yabridgemgr_sync = {
  #   serviceConfig.path = [ pkgs.yabridge ];
  # };

  environment.systemPackages = with pkgs; [
    bitwig-studio-latest
  ];
}