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

{ pkgs, ... }:

{
  # ========================================================================
  # Configuration
  # ========================================================================

  # Install OpenCode from pinned nixpkgs
  home.packages = with pkgs; [
    opencode
  ];

  # Declarative OpenCode configuration
  xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    plugin = [ "opencode-gemini-auth" ];
  };
}
