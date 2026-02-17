{
  flake.modules.nixos.network-tools =
    { pkgs, ... }:
    {
      # Network utilities
      environment.systemPackages = with pkgs; [
        gping
        rewrk
        sshfs
        upx
      ];
    };
}
