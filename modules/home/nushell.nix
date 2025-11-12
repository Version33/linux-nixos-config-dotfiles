_:

{
  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true; # Better integration with nix

    config = {
      global.hide_env_diff = true; # Hide the long export list
    };
  };

  programs.nushell = {
    enable = true;
    shellAliases = {
      # nix-shell = "nix-shell --command nu";
      lgit = "lazygit";
      conf = "z ~/.config";
      nixos = "z /etc/nixos";
      nswitch = "sudo nixos-rebuild switch --flake /etc/nixos#k0or";
      # nswitchu = "{ sudo nix flake update --flake /etc/nixos; sudo nixos-rebuild switch --flake /etc/nixos#k0or --upgrade }";
      nsgc = "sudo nix-store --gc";
      ngc = "sudo nix-collect-garbage -d";
      ngc7 = "sudo nix-collect-garbage --delete-older-than 7d";
      ngc14 = "sudo nix-collect-garbage --delete-older-than 14d";
      format-nix = "ls *.nix | each { |f| sudo nixfmt $f.name }";
      reboot-to-windows = "sudo efibootmgr --bootnext 0000; and systemctl reboot";
    };
    settings = {
      show_banner = false;
    };
    # configFile.text = "fastfetch";
  };
}
