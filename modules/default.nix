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

    # Network & Security
    ./firewall.nix
    # ./networking.nix
    # ./open-ssh.nix
    # ./dns.nix
    # ./vpn.nix

    # System Services
    ./services.nix
    ./fonts.nix
    # ./auto-upgrade.nix
    # ./gc.nix
    # ./printing.nix
    # ./clamav-scanner.nix
    # ./security-services.nix

    # User Configuration
    ./users.nix
    # ./yubikey.nix

    # Desktop Environment
    ./kde.nix
    # ./gnome.nix
    # ./display-manager.nix
    # ./theme.nix

    # Development Tools
    ./lsp.nix
    ./info-fetchers.nix
    ./utils.nix
    ./terminal-utils.nix
    # ./programming-languages.nix
    # ./rust.nix
    # ./llm.nix
    # ./virtualisation.nix

    # Audio Production
    ./audio.nix
    ./windows-vst.nix

    # Home Manager
    ./home/home.nix

    # Optional/Unused
    # ./location.nix
  ];
}
