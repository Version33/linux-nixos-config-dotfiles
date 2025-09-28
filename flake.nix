{
  description = "v33's NixOS Configuration"; # forked from https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    wezterm.url = "github:wez/wezterm?dir=nix";
    radicle-tui.url = "git+https://seed.radicle.xyz/z39mP9rQAaGmERfUMPULfPUi473tY.git?rev=dcc51b96a90d6e63cd69fae7f29e896f13816a1f";
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    home-manager.url = "github:nix-community/home-manager";
    audio = {
      url = "path:./audio";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    {
      nixosConfigurations.k0or = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          inputs.lanzaboote.nixosModules.lanzaboote
          ./modules/secure-boot.nix
          ./modules/amdgpu.nix
          ./modules/graphics.nix
          # ./modules/clamav-scanner.nix
          # ./modules/yubikey.nix
          ./modules/sound.nix
          ./modules/usb.nix
          ./modules/udev.nix
          ./modules/time.nix
          ./modules/swap.nix
          ./modules/bootloader.nix
          ./modules/nix-settings.nix
          ./modules/nixpkgs.nix
          ./modules/gc.nix
          # ./modules/auto-upgrade.nix
          ./modules/linux-kernel.nix
          # ./modules/location.nix
          ./modules/display-manager.nix
          ./modules/theme.nix
          ./modules/internationalisation.nix
          ./modules/fonts.nix
          ./modules/security-services.nix
          ./modules/services.nix
          # ./modules/printing.nix
          # ./modules/gnome.nix
          ./modules/hyprland.nix
          ./modules/environment-variables.nix
          ./modules/bluetooth.nix
          # ./modules/networking.nix
          # ./modules/mac-randomize.nix
          # ./modules/open-ssh.nix
          # ./modules/mosh.nix
          ./modules/firewall.nix
          # ./modules/dns.nix
          # ./modules/vpn.nix
          ./modules/users.nix
          # ./modules/virtualisation.nix
          # ./modules/programming-languages.nix
          ./modules/lsp.nix
          # ./modules/rust.nix
          # ./modules/radicle.nix
          # ./modules/wasm.nix
          ./modules/info-fetchers.nix
          ./modules/utils.nix
          ./modules/terminal-utils.nix
          # ./modules/llm.nix
          ./modules/file-mgr.nix

          inputs.home-manager.nixosModules.home-manager
          ./modules/home-mgr/home-manager.nix
        ];
      };
    };
}
