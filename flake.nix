# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    catppuccin.url = "github:catppuccin/nix";
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";
    lanzaboote.url = "github:nix-community/lanzaboote/v1.0.0";
    nix-auto-follow.url = "github:fzakaria/nix-auto-follow";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixmate.url = "github:daskladas/nixmate";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    opencode.url = "github:dan-online/opencode-nix";
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
    wrappers.url = "github:Lassulus/wrappers";
  };
}
