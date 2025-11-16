##############################################################################
# Affinity Suite Configuration
#
# Provides Affinity v3 (unified Photo/Designer/Publisher) via Wine.
# Uses mrshmllow/affinity-nix flake for declarative installation.
#
# Features:
#   - Affinity v3 (unified app with Vector, Pixel, and Layout studios)
#   - ElementalWarrior's Wine fork for compatibility
#   - Desktop integration
#
# Note: You will need to provide your own Affinity installer/license
##############################################################################

{ pkgs, inputs, ... }:

{
  environment.systemPackages = [
    inputs.affinity.packages.${pkgs.system}.v3
  ];
}
