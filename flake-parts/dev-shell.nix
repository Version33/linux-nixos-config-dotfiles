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
          nixfmt-rfc-style # Nix formatter (RFC 166 style)
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
      };
    };
}
