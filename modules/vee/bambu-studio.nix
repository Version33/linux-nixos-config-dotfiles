{ inputs, ... }:
{
  flake.modules.nixos.bambu-studio = _: {
    imports = [
      inputs.nix-flatpak.nixosModules.nix-flatpak
    ];

    services.flatpak = {
      enable = true;

      packages = [
        {
          # Temporary: Bambu Studio from Flathub (replacing nixpkgs version)
          appId = "com.bambulab.BambuStudio";
          origin = "flathub";
        }
      ];
    };
  };
}
