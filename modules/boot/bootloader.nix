{ ... }:
{

  flake.modules.nixos.bootloader =
    { pkgs, ... }:
    {
      # Bootloader.
      boot = {
        loader = {
          systemd-boot = {
            enable = true;
            configurationLimit = 10; # Keep last 10 NixOS generations
            # Allow rebooting to firmware/UEFI settings from boot menu
            consoleMode = "max"; # Better resolution for boot menu
          };
          efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";
          };
          timeout = 2;
        };
        initrd = {
          enable = true;
          verbose = false;
          systemd.enable = true;
        };
        consoleLogLevel = 5;
        plymouth = {
          enable = false;
          font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
          # themePackages = [ pkgs.catppuccin-plymouth ];
          # theme = "catppuccin-macchiato";
        };
      };
    };

}
