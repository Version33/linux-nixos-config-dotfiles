{
  description = "v33's NixOS Configuration"; # forked from https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Pinned nixpkgs with working opencode 0.15.29 (before broken 1.0.x releases)
    nixpkgs-opencode.url = "github:NixOS/nixpkgs/876df71365b3c0ab2d363cd6af36a80199879430";
    flake-parts.url = "github:hercules-ci/flake-parts";
    lanzaboote.url = "github:nix-community/lanzaboote/v1.0.0";
    home-manager.url = "github:nix-community/home-manager";
    catppuccin.url = "github:catppuccin/nix";
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    claude-desktop = {
      url = "github:k3d3/claude-desktop-linux-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    affinity = {
      url = "github:mrshmllow/affinity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lazyvim = {
      url = "github:pfassina/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opencode-nvim = {
      url = "github:NickvanDyke/opencode.nvim";
      flake = false;
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [
        ./flake-parts/nixos-systems.nix
        ./flake-parts/dev-shell.nix
      ];
    };
}
