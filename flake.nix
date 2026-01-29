{
  description = "v33's NixOS Configuration"; # forked from https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles

  # ============================================================================
  # Binary Cache Configuration
  # ============================================================================
  # These settings apply only to flake operations, not the system configuration.
  # For more info: https://nixos-and-flakes.thiscute.world/nix-store/add-binary-cache-servers
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # ============================================================================
  # Flake Inputs
  # ============================================================================
  # Using `follows` ensures all inputs use the same nixpkgs version,
  # reducing closure size and preventing version conflicts.
  # Reference: https://wiki.nixos.org/wiki/Flakes#Input_schema
  inputs = {
    # Core nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # OpenCode CLI with latest patches
    opencode = {
      url = "github:anomalyco/opencode";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake architecture
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Secure boot support
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # User environment management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System-wide theming
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # KDE Plasma configuration
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Claude Desktop for Linux
    claude-desktop = {
      url = "github:k3d3/claude-desktop-linux-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Affinity Suite via Wine
    affinity = {
      url = "github:mrshmllow/affinity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # LazyVim Neovim configuration
    lazyvim = {
      url = "github:pfassina/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim AI integration (non-flake)
    opencode-nvim = {
      url = "github:NickvanDyke/opencode.nvim";
      flake = false;
    };

    # Declarative Flatpak management
    # Note: nix-flatpak doesn't expose a nixpkgs input, so no follows needed
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";

    # Rust toolchain overlay (for optional rust.nix module)
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Dendritic pattern support
    import-tree.url = "github:vic/import-tree";
  };

  outputs =
    inputs@{ flake-parts, import-tree, ... }:
    # let
    #   dendriticImports = import-tree ./modules;
    # in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [
        inputs.flake-parts.flakeModules.modules
        ./flake-modules/nixos-systems.nix
        ./flake-modules/dev-shell.nix
        ./modules/development/lsp.nix
      ];
      # ++ dendriticImports.imports;
    };
}
