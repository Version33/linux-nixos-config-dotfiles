{ inputs, ... }:
{
  # Declarative Flatpak management
  # Note: nix-flatpak doesn't expose a nixpkgs input, so no follows needed
  flake-file.inputs.nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";

  flake.modules.nixos.hytale = _: {
    imports = [
      inputs.nix-flatpak.nixosModules.nix-flatpak
    ];

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
  };

}
