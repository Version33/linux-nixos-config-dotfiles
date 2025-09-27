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
      ];
    };
  };
}
