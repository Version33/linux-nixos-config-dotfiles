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
    {
      nixosConfigurations.k0or = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./modules/linux-kernel.nix

          ./modules/secure-boot.nix
          ./modules/amdgpu.nix
          ./modules/graphics.nix
          ./modules/sound.nix
          ./modules/usb.nix
          ./modules/udev.nix
          ./modules/time.nix
          ./modules/bootloader.nix
          ./modules/nix-settings.nix
          ./modules/nixpkgs.nix
          ./modules/internationalisation.nix

          ./modules/services.nix
          ./modules/fonts.nix
          ./modules/bluetooth.nix


          # ./modules/clamav-scanner.nix
          # ./modules/yubikey.nix
          # ./modules/gc.nix
          # ./modules/auto-upgrade.nix
          # ./modules/location.nix
          # ./modules/display-manager.nix
          # ./modules/theme.nix
          # ./modules/security-services.nix
          # ./modules/printing.nix
          # ./modules/gnome.nix
          ./modules/environment-variables.nix
          # ./modules/networking.nix
          # ./modules/open-ssh.nix
          ./modules/firewall.nix
          # ./modules/dns.nix
          # ./modules/vpn.nix
          ./modules/users.nix
          # ./modules/virtualisation.nix
          # ./modules/programming-languages.nix
          ./modules/lsp.nix
          # ./modules/rust.nix
          ./modules/info-fetchers.nix
          ./modules/utils.nix
          ./modules/terminal-utils.nix
          # ./modules/llm.nix
          ./modules/audio.nix
          ./modules/kde.nix
          ./modules/home/home.nix
        ];
      };
    };
}
