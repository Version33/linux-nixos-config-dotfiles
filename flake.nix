# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    audio-nix.url = "github:polygon/audio.nix";
    catppuccin.url = "github:catppuccin/nix";
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    lanzaboote.url = "github:nix-community/lanzaboote/v1.0.0";
    nix-auto-follow.url = "github:fzakaria/nix-auto-follow";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixmate.url = "github:daskladas/nixmate";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    opencode.url = "github:anomalyco/opencode";
    plasma-manager.url = "github:nix-community/plasma-manager";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    wrappers.url = "github:Lassulus/wrappers";
  };

}
