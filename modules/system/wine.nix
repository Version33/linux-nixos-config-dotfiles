{ ... }:
{
  flake.modules.nixos.wine =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        wineWowPackages.staging
        winetricks
        wine64Packages.fonts
      ];

      # Enable 32-bit support for Wine (required for many Windows apps)
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
}
