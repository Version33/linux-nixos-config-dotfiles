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
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          # Nix development tools
          nixd # Nix language server
          nixfmt-rfc-style # Nix code formatter (RFC 166 style, more options)
          # nixpkgs-fmt     # Alternative formatter (less configurable)
          statix # Lints and suggestions for Nix code
          deadnix # Find and remove unused code
          nix-tree # Visualize dependency tree
          nix-output-monitor # Better build output (alias: nom)

          # Development environment tools
          direnv # Automatic environment activation
          nix-direnv # Fast direnv integration for Nix

          # Useful utilities
          git
          just # Command runner (for justfile)
        ];

        shellHook = ''
          echo "NixOS Configuration Development Environment"
          echo "Available tools:"
          echo "  - nixd: Nix LSP server"
          echo "  - nixfmt: Format nix files (RFC 166 style)"
          echo "  - statix: Lint nix code"
          echo "  - deadnix: Find unused code"
          echo "  - nix-tree: Visualize dependencies"
          echo "  - nom: Better nix build output (nix-output-monitor)"
          echo "  - direnv: Automatic environment activation"
          echo ""
          echo "Try: nixfmt . to format all files"
          echo "Try: statix check . to check for issues"
          echo "Try: nom build instead of nix build for better output"
          echo ""
          echo "Setup direnv: Run 'just setup-direnv' to configure direnv hooks"
        '';
      };
    };
}
