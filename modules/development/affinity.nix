{ inputs, ... }:
{

  flake.modules.nixos.affinity =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        inputs.affinity.packages.${pkgs.stdenv.hostPlatform.system}.v3
      ];
    };

}
