##############################################################################
# Bambu Studio Latest Release
#
# This module provides the latest Bambu Studio release with H2C printer support
# by fetching and wrapping the official AppImage release.
#
# The AppImage is fetched from GitHub releases and wrapped into a proper
# Nix package that can be launched like any other application.
#
# Features:
#   - H2C printer support (multi-nozzle system)
#   - Hybrid Mode slicing with high-flow and standard nozzles
#   - Purge mode options (Standard and Purge Saving)
#   - Nozzle mapping for specific filaments
##############################################################################

{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (
      final: prev:
      let
        pname = "bambu-studio-latest";
        version = "2.4.0";
        src = pkgs.fetchurl {
          url = "https://github.com/bambulab/BambuStudio/releases/download/v02.04.00.70/Bambu_Studio_ubuntu-22.04_PR-8834.AppImage";
          hash = "sha256-/xcVD3YPuAr8mNmEGxNMC62kiX1qrzaAi1F6S+0sEbA=";
        };
        appimageContents = pkgs.appimageTools.extract { inherit pname version src; };
      in
      {
        bambu-studio-latest = pkgs.appimageTools.wrapType2 {
          inherit pname version src;

          extraPkgs =
            pkgs: with pkgs; [
              # Additional libraries that might be needed
              webkitgtk_4_1
              glib-networking
              # GStreamer plugins for H.264 video streaming from printer
              gst_all_1.gstreamer
              gst_all_1.gst-plugins-base
              gst_all_1.gst-plugins-good
              gst_all_1.gst-plugins-bad
              gst_all_1.gst-plugins-ugly
              gst_all_1.gst-libav
              gst_all_1.gst-vaapi # Hardware-accelerated video decoding for AMD/Intel
              # Hardware video acceleration libraries
              libva
              mesa
            ];

          extraInstallCommands = ''
            # Install desktop file
            install -Dm444 ${appimageContents}/BambuStudio.desktop \
              $out/share/applications/bambu-studio-latest.desktop

            substituteInPlace $out/share/applications/bambu-studio-latest.desktop \
              --replace 'Exec=AppRun' 'Exec=bambu-studio-latest' \
              --replace 'Name=Bambu Studio' 'Name=Bambu Studio (Latest)' \
              --replace 'Icon=BambuStudio' 'Icon=bambu-studio-latest'

            # Install icon
            install -Dm444 ${appimageContents}/BambuStudio.png \
              $out/share/pixmaps/bambu-studio-latest.png
          '';

          meta = with pkgs.lib; {
            description = "Bambu Studio latest release with H2C support";
            homepage = "https://github.com/bambulab/BambuStudio";
            license = licenses.agpl3Only;
            platforms = platforms.linux;
            mainProgram = "bambu-studio-latest";
          };
        };
      }
    )
  ];

  # Install the package
  environment.systemPackages = with pkgs; [ bambu-studio-latest ];
}
