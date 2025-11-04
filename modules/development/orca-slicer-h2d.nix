##############################################################################
# Orca Slicer with H2D Support
#
# This module provides a custom build of OrcaSlicer with H2D/H2S printer
# support by building from the main branch instead of the stable release.
#
# H2D support was merged in PR #10780 on October 24, 2024.
#
# For H2D printer support:
#   - Enable both LAN mode AND developer mode on your H2D printer
#   - Turn off "Use legacy network plugin" in Orca's preferences
#   - Delete ~/.config/OrcaSlicer/system/ before first launch
##############################################################################

{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      orca-slicer = prev.orca-slicer.overrideAttrs (oldAttrs: rec {
        version = "2.3.2-dev-unstable-2024-11-04";

        src = pkgs.fetchFromGitHub {
          owner = "SoftFever";
          repo = "OrcaSlicer";
          # Building from main branch commit with H2D support
          rev = "3c65617139c439730c8ef6ad787430c04605b6b4";
          hash = "sha256-hz/Y0o8zhGTCfUPYn+1ey4X2Lqiscr7Nt9v3sXqkbqg=";
        };

        # The newer commit changed Findlibnoise.cmake to use LIBNOISE_LIBRARY_RELEASE
        # instead of LIBNOISE_LIBRARY, so we need to update the cmake flags
        cmakeFlags = builtins.map (flag:
          if flag == (pkgs.lib.cmakeFeature "LIBNOISE_LIBRARY" "${pkgs.libnoise}/lib/libnoise-static.a")
          then (pkgs.lib.cmakeFeature "LIBNOISE_LIBRARY_RELEASE" "${pkgs.libnoise}/lib/libnoise-static.a")
          else flag
        ) oldAttrs.cmakeFlags;
      });
    })
  ];
}
