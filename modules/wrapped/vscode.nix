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
          "workbench.colorTheme" = "Catppuccin Mocha";
          "workbench.iconTheme" = "catppuccin-mocha";
          "catppuccin.accentColor" = "blue";
          "editor.semanticHighlighting.enabled" = true;
          "terminal.integrated.minimumContrastRatio" = 1;
          "window.titleBarStyle" = "custom";
        }
      );

      # VSCodium with extensions baked in (generates correct extensions.json)
      codiumWithExtensions = pkgs.vscode-with-extensions.override {
        vscode = pkgs.vscodium;
        vscodeExtensions = with pkgs.vscode-extensions; [
          vscodevim.vim
          visualstudioexptteam.vscodeintellicode
          christian-kohler.path-intellisense
          jnoortheen.nix-ide
          jeff-hykin.better-nix-syntax
          formulahendry.code-runner
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
        ];
      };
    in
    {
      packages.vscode = pkgs.writeShellApplication {
        name = "codium";
        runtimeInputs = [ codiumWithExtensions ];
        text = ''
          # Copy settings if they don't exist or are older
          mkdir -p ~/.config/VSCodium/User
          if [ ! -f ~/.config/VSCodium/User/settings.json ] || \
             [ ${userSettings} -nt ~/.config/VSCodium/User/settings.json ]; then
            cp ${userSettings} ~/.config/VSCodium/User/settings.json
          fi

          exec codium "$@"
        '';
      };
    };

  flake.modules.nixos.wrapped-vscode =
    { self, pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.vscode
      ];
    };
}
