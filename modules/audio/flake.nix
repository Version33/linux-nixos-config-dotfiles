{
  description = "Overlay for my custom audio plugins";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    audio.url   = "github:polygon/audio.nix";
  };

  outputs = { self, nixpkgs, audio, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ audio.overlays.default ];
      };
    in {
      packages.${system} = {
        wine-serum2 = pkgs.callPackage ./plugins/serum2.nix { };
      };

      overlays.default = final: prev: {
        # add to overlay so it can be used like audio plugins
        wine-serum2 = self.packages.${system}.serum2;
      };
    };
}
