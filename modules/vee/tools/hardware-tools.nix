{
  flake.modules.nixos.hardware-tools =
    { pkgs, ... }:
    {
      # Hardware management utilities
      environment.systemPackages = with pkgs; [
        gparted
        ntfs3g
        efibootmgr
      ];
    };
}
