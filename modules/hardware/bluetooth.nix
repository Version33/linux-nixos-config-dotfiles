{

  flake.modules.nixos.bluetooth =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        overskride
      ];
    };

}
