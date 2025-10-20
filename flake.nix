{
  description = "v33's NixOS Configuration"; # forked from https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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

  outputs =
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.k0or = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./modules
        ];
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          # Nix development tools
          nixd              # Nix language server
          nixpkgs-fmt       # Nix code formatter
          statix            # Lints and suggestions for Nix code
          deadnix           # Find and remove unused code
          nix-tree          # Visualize dependency tree

          # Useful utilities
          git
          just              # Command runner (for justfile)
        ];

        shellHook = ''
          echo "NixOS Configuration Development Environment"
          echo "Available tools:"
          echo "  - nixd: Nix LSP server"
          echo "  - nixpkgs-fmt: Format nix files"
          echo "  - statix: Lint nix code"
          echo "  - deadnix: Find unused code"
          echo "  - nix-tree: Visualize dependencies"
          echo ""
          echo "Try: nixpkgs-fmt . to format all files"
          echo "Try: statix check . to check for issues"
        '';
      };
    };
}
