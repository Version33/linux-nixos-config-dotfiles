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
        ./modules/development/rust.nix
        ./modules/development/info-fetchers.nix
        ./modules/development/utils.nix
        ./modules/development/terminal-utils.nix
        ./modules/development/programming-languages.nix
        ./modules/development/affinity.nix
        ./modules/development/llm.nix
        ./modules/development/orca-slicer-nightly.nix
        ./modules/development/virtualisation.nix
        ./modules/gaming/hytale.nix
        ./modules/hardware/amdgpu.nix
        ./modules/hardware/rgb.nix
        ./modules/hardware/bluetooth.nix
        ./modules/hardware/gaming.nix
        ./modules/hardware/graphics.nix
        ./modules/hardware/udev.nix
        ./modules/hardware/usb.nix
        ./modules/hardware/sound.nix
        ./modules/home/starship.nix
        ./modules/home/git.nix
        ./modules/home/ssh.nix
        ./modules/home/kitty.nix
        ./modules/home/nushell.nix
        ./modules/home/vscode.nix
        ./modules/home/plasma.nix
        ./modules/home/yabridge.nix
        ./modules/home/opencode.nix
        ./modules/home/lsp-plugins.nix
        ./modules/home/lazyvim.nix
        ./modules/home/home.nix
        ./modules/boot/bootloader.nix
        ./modules/boot/linux-kernel.nix
        ./modules/boot/secure-boot.nix
        ./modules/system/time.nix
        ./modules/system/nix-settings.nix
        ./modules/system/nixpkgs.nix
        ./modules/system/internationalisation.nix
        ./modules/system/environment-variables.nix
        ./modules/system/vm.nix
        ./modules/network/networking.nix
        ./modules/network/firewall.nix
        ./modules/network/dns.nix
        ./modules/network/tailscale.nix
        ./modules/desktop/kde.nix
        ./modules/audio/audio.nix
        ./modules/users/users.nix
        ./modules/services/services.nix
        ./modules/services/fonts.nix
        ./modules/services/fido2.nix
        ./modules/services/gc.nix
        ./modules/services/auto-upgrade.nix
        ./modules/services/clamav-scanner.nix
        ./modules/services/location.nix
        ./modules/services/printing.nix
        ./modules/services/security-services.nix
        ./modules/audio/windows-vst.nix
        ./modules/desktop/gnome.nix
        ./modules/desktop/theme.nix
        ./modules/network/local-services.nix
        ./modules/network/open-ssh.nix
        ./modules/network/vpn.nix
      ];
      # ++ dendriticImports.imports;
    };
}
