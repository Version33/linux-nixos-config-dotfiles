##############################################################################
# Language Server Protocol (LSP) Tools
#
# Purpose: System-wide language servers for code editing
# Features:
#   - nixd: Nix language server
#   - nixfmt: Nix code formatter
#   - markdown-oxide: Markdown language server
# Note: Additional LSP servers are commented out and can be enabled as needed
##############################################################################

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # # python313Packages.python-lsp-server
    # # nodePackages_latest.nodemon
    # # nodePackages_latest.typescript
    # # nodePackages_latest.typescript-language-server
    # # nodePackages_latest.vscode-langservers-extracted
    # # nodePackages_latest.yaml-language-server
    # # nodePackages_latest.bash-language-server
    # # nodePackages_latest.graphql-language-service-cli
    # dockerfile-language-server
    # vue-language-server
    # sumneko-lua-language-server
    # marksman
    markdown-oxide
    nixd # nil
    nixfmt
    # zls
    # gopls
    # delve
    # emmet-language-server
    # buf
    # cmake-language-server
    # docker-compose-language-service
    # vscode-extensions.vadimcn.vscode-lldb
    # slint-lsp
    # terraform-ls
    # ansible-language-server
    # hyprls
    # helix-gpt
  ];
}
