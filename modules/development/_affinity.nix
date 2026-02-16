{ inputs, ... }:
{
  # Affinity Suite via Wine
  flake-file.inputs.affinity.url = "github:mrshmllow/affinity-nix";

  flake.modules.nixos.affinity =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        inputs.affinity.packages.${pkgs.stdenv.hostPlatform.system}.v3
      ];
    };

}
