##############################################################################
# OpenCode Configuration
#
# Purpose: Configure OpenCode CLI with Gemini OAuth authentication
# Features:
#   - Declarative OpenCode config.json management
#   - Gemini OAuth plugin integration
#   - Automatic plugin installation via OpenCode's bundled runtime
# Notes:
#   - After rebuild, run: opencode auth login
#   - Choose Google provider and select "OAuth with Google (Gemini CLI)"
#   - Plugins auto-install to ~/.cache/opencode/node_modules on first run
##############################################################################

{ pkgs, inputs, ... }:

{
  # ========================================================================
  # Configuration
  # ========================================================================

  # Install OpenCode from the official flake
  home.packages = [
    inputs.opencode.packages.${pkgs.system}.default
  ];

  # Declarative OpenCode configuration
  xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    plugin = [ "opencode-gemini-auth" ];
  };
}
