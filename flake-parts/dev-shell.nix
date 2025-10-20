##############################################################################
# Development Shell
#
# Purpose: Provide development environment for working on this config
# Features:
#   - Nix language tools (nixd, nixpkgs-fmt, statix)
#   - Code quality tools (deadnix)
#   - Visualization tools (nix-tree)
#   - Command runner (just)
##############################################################################

{ inputs, ... }:

{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        # Nix development tools
        nixd              # Nix language server
        nixpkgs-fmt       # Nix code formatter
        statix            # Lints and suggestions for Nix code
        deadnix           # Find and remove unused code
        nix-tree          # Visualize dependency tree

        # Useful utilities
        git
        just              # Command runner (for justfile)
      ];

      shellHook = ''
        echo "NixOS Configuration Development Environment"
        echo "Available tools:"
        echo "  - nixd: Nix LSP server"
        echo "  - nixpkgs-fmt: Format nix files"
        echo "  - statix: Lint nix code"
        echo "  - deadnix: Find unused code"
        echo "  - nix-tree: Visualize dependencies"
        echo ""
        echo "Try: nixpkgs-fmt . to format all files"
        echo "Try: statix check . to check for issues"
      '';
    };
  };
}
