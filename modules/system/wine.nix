{ ... }:
{
  flake.modules.nixos.wine =
    { pkgs, ... }:
    {
      # ============================================================================
      # Wine Configuration
      # ============================================================================
      # Wine is needed to run Windows applications like Bambu Suite (laser cutter)
      # Using wine-staging for better compatibility and latest features

      environment.systemPackages = with pkgs; [
        # Wine with staging patches for better compatibility
        wineWowPackages.staging

        # Winetricks for managing Wine prefixes and installing dependencies
        winetricks

        # Wine utilities
        wine64Packages.fonts # Windows fonts for better app rendering
      ];

      # Enable 32-bit support for Wine (required for many Windows apps)
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
}
