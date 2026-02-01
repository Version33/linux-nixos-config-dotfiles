{ ... }:
{

  flake.modules.nixos.orca-slicer =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        (
          _final: _prev:
          let
            pname = "orca-slicer-nightly";
            version = "nightly-2026-01-25";
            src = pkgs.fetchurl {
              url = "https://github.com/OrcaSlicer/OrcaSlicer/releases/download/nightly-builds/OrcaSlicer_Linux_AppImage_Ubuntu2404_nightly.AppImage";
              hash = "sha256-sDBC89soHfvIYaSxz6NcbJJ1O+64vrKf4apDoS7LF10=";
            };
            appimageContents = pkgs.appimageTools.extract { inherit pname version src; };
          in
          {
            orca-slicer-nightly = pkgs.appimageTools.wrapType2 {
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
                install -Dm444 ${appimageContents}/OrcaSlicer.desktop \
                  $out/share/applications/orca-slicer-nightly.desktop

                substituteInPlace $out/share/applications/orca-slicer-nightly.desktop \
                  --replace 'Exec=AppRun' 'Exec=orca-slicer-nightly' \
                  --replace 'Name=OrcaSlicer' 'Name=OrcaSlicer Nightly' \
                  --replace 'Icon=OrcaSlicer' 'Icon=orca-slicer-nightly'

                # Install icon
                install -Dm444 ${appimageContents}/OrcaSlicer.png \
                  $out/share/pixmaps/orca-slicer-nightly.png
              '';

              meta = with pkgs.lib; {
                description = "OrcaSlicer nightly build with H2D/H2S support";
                homepage = "https://github.com/OrcaSlicer/OrcaSlicer";
                license = licenses.agpl3Only;
                platforms = platforms.linux;
                mainProgram = "orca-slicer-nightly";
              };
            };
          }
        )
      ];
    };

}
