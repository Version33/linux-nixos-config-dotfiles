##############################################################################
# Module Organization
#
# This file aggregates all NixOS configuration modules.
# Modules are organized by category for easy management.
#
# Creating a new module:
#   See modules/README.md and modules/TEMPLATE.nix
#
# To enable an optional module:
#   1. Uncomment the desired module path below
#   2. Run: just switch (or sudo nixos-rebuild switch --flake .#k0or)
#
# To disable an active module:
#   1. Comment out the module path
#   2. Run: just switch
##############################################################################

{ ... }:

{
  imports = [
    # Boot & Kernel
    ./linux-kernel.nix
    ./secure-boot.nix
    ./bootloader.nix

    # Hardware Support
    ./amdgpu.nix
    ./graphics.nix
    ./sound.nix
    ./bluetooth.nix
    ./usb.nix
    ./udev.nix

    # System Settings
    ./time.nix
    ./nix-settings.nix
    ./nixpkgs.nix
    ./internationalisation.nix
    ./environment-variables.nix
    ./vm.nix

    # Network & Security
    ./firewall.nix
    ./optional/dns.nix

    # System Services
    ./services.nix
    ./fonts.nix

    # User Configuration
    ./users.nix

    # Desktop Environment
    ./kde.nix

    # Development Tools
    ./lsp.nix
    ./info-fetchers.nix
    ./utils.nix
    ./terminal-utils.nix

    # Audio Production
    ./audio.nix
    ./windows-vst.nix

    # Home Manager
    ./home/home.nix

    # Optional modules available in ./optional/
    # To enable, uncomment the desired module below:
    # ./optional/networking.nix
    # ./optional/open-ssh.nix
    # ./optional/vpn.nix
    # ./optional/auto-upgrade.nix
    # ./optional/gc.nix
    # ./optional/printing.nix
    # ./optional/clamav-scanner.nix
    # ./optional/security-services.nix
    # ./optional/yubikey.nix
    # ./optional/gnome.nix
    # ./optional/display-manager.nix
    # ./optional/theme.nix
    # ./optional/programming-languages.nix
    # ./optional/rust.nix
    # ./optional/llm.nix
    # ./optional/virtualisation.nix
    # ./optional/location.nix
  ];
}
