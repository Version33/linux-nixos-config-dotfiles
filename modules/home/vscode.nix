{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        visualstudioexptteam.vscodeintellicode
        christian-kohler.path-intellisense
        jnoortheen.nix-ide
        jeff-hykin.better-nix-syntax
        formulahendry.code-runner
        # sst-dev.opencode # does not exist yet
        # anthropic.claude-code
        # Google.gemini-cli-vscode-ide-companion

        # catppuccin.catppuccin-vsc
        # catppuccin.catppuccin-vsc-icons
      ];
      userSettings = {
        "claudeCode.useTerminal" = true;
        "git.confirmSync" = false;
      };
    };
  };
}
