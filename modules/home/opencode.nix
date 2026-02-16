{ inputs, ... }:
{
  # OpenCode CLI with latest patches
  flake-file.inputs.opencode.url = "github:anomalyco/opencode";

  flake.modules.homeManager.opencode =
    { pkgs, ... }:
    {
      # Install OpenCode from the official flake
      home.packages = [
        inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      # Declarative OpenCode configuration
      xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
        "$schema" = "https://opencode.ai/config.json";
        plugin = [ "opencode-gemini-auth" ];
      };
    };

}
