{
  inputs,
  lib,
  ...
}:
{
  flake-file.inputs.opencode-nix = {
    url = "github:dan-online/opencode-nix";
  };

  perSystem =
    { pkgs, inputs', ... }:
    let
      opencodeConf =
        pkgs.writeText "opencode.json"
          (builtins.toJSON {
            "$schema" = "https://opencode.ai/config.json";
            plugin = [
              "opencode-gemini-auth"
              "opencode-claude-bridge"
            ];
          });
    in
    {
      packages.opencode =
        pkgs.symlinkJoin {
          name = "opencode";
          paths = [
            inputs'.opencode-nix.packages.default
          ];
          nativeBuildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/opencode \
              --set OPENCODE_CONFIG ${opencodeConf}
          '';
        };
    };

  flake.modules.nixos.wrapped-opencode =
    { self, pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.opencode
      ];
    };
}