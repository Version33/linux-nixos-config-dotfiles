{ pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Override to opencode 1.0.24 (latest release)
  # Note: dontStrip is critical - stripping breaks the opencode binary!
  nixpkgs.overlays = [
    (final: prev: {
      opencode = prev.opencode.overrideAttrs (oldAttrs: rec {
        version = "1.0.24";
        src = prev.fetchzip {
          url = "https://github.com/sst/opencode/releases/download/v${version}/opencode-linux-x64.zip";
          hash = "sha256-IRhZlgb+bK45A+Ph8DNL/LjHAYZ+3H+Cty2v9IZy5uU=";
        };
        dontStrip = true;
        installPhase = ''
          runHook preInstall

          install -Dm 755 $src/opencode $out/bin/opencode

          runHook postInstall
        '';
      });
    })
  ];

  # Override packages
  # nixpkgs.config.packageOverrides = pkgs: {
  #   nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
  #     inherit pkgs;
  #   };
  # };
}
