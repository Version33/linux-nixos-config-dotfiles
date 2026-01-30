{ inputs, ... }:
{
  # Secure boot support
  flake-file.inputs.lanzaboote.url = "github:nix-community/lanzaboote/v1.0.0";

  flake.modules.nixos.secure-boot =
    { pkgs, lib, ... }:
    {
      imports = [
        inputs.lanzaboote.nixosModules.lanzaboote
      ];

      environment.systemPackages = [
        pkgs.sbctl # For debugging and troubleshooting Secure Boot.
      ];

      # Lanzaboote requires disabling the default systemd-boot loader
      boot.loader.systemd-boot.enable = lib.mkForce false;

      # Enable and configure Lanzaboote
      boot.lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };

}
