{ inputs, ... }:
{
  # OpenCode CLI with latest patches
  flake-file.inputs.opencode.url = "github:anomalyco/opencode";

  perSystem =
    { pkgs, ... }:
    let
      settings = {
        "$schema" = "https://opencode.ai/config.json";
        plugin = [ "opencode-gemini-auth" ];
      };

      configFile = pkgs.writeText "opencode.json" (builtins.toJSON settings);
    in
    {
      packages.opencode = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default;
        env = {
          OPENCODE_CONFIG_FILE = toString configFile;
        };
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
