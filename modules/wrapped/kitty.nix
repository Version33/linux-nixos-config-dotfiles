{ inputs, lib, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      settings = {
        font_family = "JetBrainsMono Nerd Font Mono";
        font_size = 13;

        allow_remote_control = "yes";
        listen_on = "unix:@mykitty";
        shell_integration = "enabled";
      };

      kittyKeyValueFormat = pkgs.formats.keyValue {
        listsAsDuplicateKeys = true;
        mkKeyValue = lib.generators.mkKeyValueDefault { } " ";
      };

      baseConfig = kittyKeyValueFormat.generate "kitty.conf" settings;

      configFile = pkgs.writeText "kitty.conf" ''
        ${builtins.readFile baseConfig}
        include ${pkgs.kitty-themes}/share/kitty-themes/Catppuccin-Mocha.conf
      '';
    in
    {
      packages.kitty = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.kitty;
        flags = {
          "-c" = toString configFile;
        };
      };
    };

}
