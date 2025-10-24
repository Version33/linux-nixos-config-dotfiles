# Windows VST Plugin Management Module
#
# This module automatically discovers and integrates Windows VST plugins
# from the modules/audio/plugins/ directory.
#
# To add a new plugin:
# 1. Create a new .nix file in modules/audio/plugins/ (e.g., my-plugin.nix)
# 2. Follow the pattern used in serum2.nix:
#    - Use stdenvNoCC.mkDerivation
#    - Install the VST using wine and xvfb-run
#    - Copy the VST3/VST files to $out
# 3. Rebuild your system - the plugin will be automatically discovered
# 4. Run: yabridgectl sync
#
# The plugins will be available in your DAW (e.g., Bitwig Studio) via yabridge.

{ pkgs, lib, ... }:

let
  # Directory containing plugin definitions
  pluginsDir = ./plugins;

  # Auto-discover all .nix files in the plugins directory
  pluginFiles = builtins.filter (name: lib.hasSuffix ".nix" name) (
    builtins.attrNames (builtins.readDir pluginsDir)
  );

  # Import each plugin as a package
  windowsPlugins = map (file: pkgs.callPackage (pluginsDir + "/${file}") { }) pluginFiles;

  # Create a bundle that symlinks all plugins together
  windowsPluginBundle = pkgs.runCommand "windows-plugin-bundle" { } ''
    mkdir -p $out
    ${lib.concatMapStringsSep "\n" (plugin: ''
      ln -s ${plugin}/* $out/ 2>/dev/null || true
    '') windowsPlugins}
  '';

in
{
  # Install required tools for Windows VST bridging
  environment.systemPackages =
    with pkgs;
    [
      # Wine for running Windows applications
      wine-staging
      winetricks

      # Yabridge for bridging Windows VSTs to Linux DAWs
      yabridge
      yabridgectl

      # The plugin bundle containing all discovered Windows VSTs
      windowsPluginBundle
    ]
    ++ windowsPlugins; # Also include individual plugins

  # Optional: Print discovered plugins during build
  # This helps verify that plugins are being discovered correctly
  system.activationScripts.windowsVstInfo = lib.stringAfter [ "etc" ] ''
    echo "Windows VST Plugins discovered: ${toString (builtins.length windowsPlugins)}"
    echo "Plugin files: ${lib.concatStringsSep ", " pluginFiles}"
  '';
}
