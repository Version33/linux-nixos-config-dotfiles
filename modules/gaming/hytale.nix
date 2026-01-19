##############################################################################
# Hytale Launcher
#
# Purpose: Install Hytale game launcher via flatpak bundle
# Features:
#   - Declarative flatpak installation using nix-flatpak
#   - Installs from local .flatpak bundle file
#   - Adds flatpak exports to XDG_DATA_DIRS for desktop integration
# Notes:
#   - Requires flatpak bundle at ~/Downloads/hytale-launcher-latest.flatpak
#   - Uses nix-flatpak module for declarative management
##############################################################################

_:

{
  services.flatpak = {
    enable = true;

    packages = [
      {
        # Install Hytale launcher from local flatpak bundle
        bundle = "file:///home/vee/Downloads/hytale-launcher-latest.flatpak";
        appId = "com.hypixel.HytaleLauncher";
        sha256 = "0h3yixfc2l4776rxyrgspgkdnmdvz3nphlxb879h9j5dmgc74n6w";
      }
    ];

    # Enable automatic updates for flatpaks
    # update.auto = {
    #   enable = true;
    #   onCalendar = "weekly";
    # };
  };

  # Add flatpak exports to XDG_DATA_DIRS so KDE can find flatpak applications
  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
    ];
  };
}
