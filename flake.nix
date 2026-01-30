# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{

  outputs = inputs: import ./. inputs;

  inputs = {
    affinity.url = "github:mrshmllow/affinity-nix";
    catppuccin.url = "github:catppuccin/nix";
    claude-desktop.url = "github:k3d3/claude-desktop-linux-flake";
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    import-tree.url = "github:vic/import-tree";
    lanzaboote.url = "github:nix-community/lanzaboote/v1.0.0";
    lazyvim.url = "github:pfassina/lazyvim-nix";
    nix-auto-follow.url = "github:fzakaria/nix-auto-follow";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    opencode.url = "github:anomalyco/opencode";
    opencode-nvim = {
      flake = false;
      url = "github:NickvanDyke/opencode.nvim";
    };
    plasma-manager = {
      inputs.home-manager.follows = "home-manager";
      url = "github:nix-community/plasma-manager";
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

}
