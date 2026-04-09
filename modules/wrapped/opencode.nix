{
  flake-file.inputs.opencode-nix = {
    url = "github:dan-online/opencode-nix";
  };

  perSystem =
    {
      pkgs,
      inputs',
      self',
      ...
    }:
    let
      meridian = self'.packages.meridian or null;
      opencodeConf = pkgs.writeText "opencode.json" (
        builtins.toJSON {
          "$schema" = "https://opencode.ai/config.json";
          plugin = [
            "opencode-gemini-auth"
            "opencode-claude-bridge"
          ]
          ++ pkgs.lib.optional (meridian != null) "${meridian}/lib/meridian/plugin/meridian.ts";
        }
      );
    in
    {
      packages.opencode = pkgs.symlinkJoin {
        name = "opencode";
        paths = [
          inputs'.opencode-nix.packages.default
        ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild =
          let
            wrapArgs = pkgs.lib.concatStringsSep " \\\n    " (
              [ "--set OPENCODE_CONFIG ${opencodeConf}" ]
              ++ pkgs.lib.optionals (meridian != null) [
                "--set ANTHROPIC_API_KEY x"
                "--set ANTHROPIC_BASE_URL http://127.0.0.1:3456"
              ]
            );
          in
          ''
            wrapProgram $out/bin/opencode \
              ${wrapArgs}
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
