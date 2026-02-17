{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      # VSCode user settings
      userSettings = pkgs.writeText "settings.json" (
        builtins.toJSON {
          "claudeCode.useTerminal" = true;
          "git.confirmSync" = false;
        }
      );

      # Extensions to install
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        visualstudioexptteam.vscodeintellicode
        christian-kohler.path-intellisense
        jnoortheen.nix-ide
        jeff-hykin.better-nix-syntax
        formulahendry.code-runner
      ];

      # Create extension directory structure
      extensionsDir = pkgs.symlinkJoin {
        name = "vscode-extensions";
        paths = extensions;
      };
    in
    {
      # Wrapped VSCodium with extensions and settings
      packages.vscode = pkgs.writeShellApplication {
        name = "codium";
        runtimeInputs = [ pkgs.vscodium ];
        text = ''
          # Create config directory if it doesn't exist
          mkdir -p ~/.config/VSCodium/User

          # Copy settings if they don't exist or are older
          if [ ! -f ~/.config/VSCodium/User/settings.json ] || \
             [ ${userSettings} -nt ~/.config/VSCodium/User/settings.json ]; then
            cp ${userSettings} ~/.config/VSCodium/User/settings.json
          fi

          # Launch VSCodium with extensions
          exec ${pkgs.vscodium}/bin/codium \
            --extensions-dir ${extensionsDir}/share/vscode/extensions \
            "$@"
        '';
      };
    };

}
