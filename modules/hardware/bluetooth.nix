{ ... }:
{

  flake.modules.nixos.bluetooth =
    { pkgs, ... }:
    {
      # Enable Bluetooth
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;

      environment.systemPackages = with pkgs; [
        overskride
      ];
    };

}
