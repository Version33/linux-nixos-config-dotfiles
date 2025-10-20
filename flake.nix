{
  description = "v33's NixOS Configuration"; # forked from https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    home-manager.url = "github:nix-community/home-manager";
    catppuccin.url = "github:catppuccin/nix";
    audio-nix = {
      url = "github:polygon/audio.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [
        ./flake-parts/nixos-systems.nix
        ./flake-parts/dev-shell.nix
      ];
    };
}
