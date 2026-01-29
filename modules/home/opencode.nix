{ inputs, ... }:
{

  flake.modules.homeManager.opencode =
    { pkgs, ... }:
    {
      # Install OpenCode from the official flake
      home.packages = [
        inputs.opencode.packages.${pkgs.system}.default
      ];

      # Declarative OpenCode configuration
      xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
        "$schema" = "https://opencode.ai/config.json";
        plugin = [ "opencode-gemini-auth" ];
      };
    };

}
