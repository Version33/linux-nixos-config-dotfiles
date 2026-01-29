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
    # Boot & Kernel - Now loaded via dendritic pattern
    # ./boot/linux-kernel.nix
    # ./boot/secure-boot.nix
    # ./boot/bootloader.nix

    # Hardware Support - Now loaded via dendritic pattern
    # ./hardware/amdgpu.nix
    # ./hardware/graphics.nix
    # ./hardware/sound.nix
    # ./hardware/bluetooth.nix
    # ./hardware/usb.nix
    # ./hardware/udev.nix
    # ./hardware/rgb.nix
    # ./hardware/gaming.nix

    # System Settings - Now loaded via dendritic pattern
    # ./system/time.nix
    # ./system/nix-settings.nix
    # ./system/nixpkgs.nix
    # ./system/internationalisation.nix
    # ./system/environment-variables.nix
    # ./system/vm.nix

    # Network & Security - Now loaded via dendritic pattern
    # ./network/networking.nix
    # ./network/firewall.nix
    # ./network/dns.nix
    # ./network/tailscale.nix
    # ./network/local-services.nix

    # Desktop Environment - Now loaded via dendritic pattern
    # ./desktop/kde.nix

    # Development Tools - Now loaded via dendritic pattern
    # ./development/lsp.nix
    # ./development/info-fetchers.nix
    # ./development/utils.nix
    # ./development/terminal-utils.nix
    # ./development/affinity.nix
    # ./development/orca-slicer-nightly.nix

    # Audio Production - Now loaded via dendritic pattern
    # ./audio/audio.nix
    # ./audio/windows-vst.nix

    # Users - Now loaded via dendritic pattern
    # ./users/users.nix

    # Services - Now loaded via dendritic pattern
    # ./services/services.nix
    # ./services/fonts.nix
    # ./services/fido2.nix
    # ./services/gc.nix

    # Gaming - Now loaded via dendritic pattern
    # ./gaming/hytale.nix

    # Home Manager - Now loaded via dendritic pattern
    # ./home/home.nix

    # Optional modules - uncomment to enable:
    # Network
    # ./network/open-ssh.nix
    # ./network/vpn.nix

    # Desktop
    # ./desktop/gnome.nix
    # ./desktop/theme.nix

    # Development
    # ./development/programming-languages.nix
    # ./development/rust.nix
    # ./development/llm.nix
    # ./development/virtualisation.nix

    # Services
    # ./services/auto-upgrade.nix
    # ./services/gc.nix
    # ./services/printing.nix
    # ./services/clamav-scanner.nix
    # ./services/security-services.nix
    # ./services/location.nix
  ];
}
