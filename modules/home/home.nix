{ pkgs, inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.catppuccin.nixosModules.catppuccin
  ];
  
  home-manager.users.vee =
    {
      home.username = "vee";
      home.homeDirectory = "/home/vee";
      nixpkgs.config.allowUnfree = true;

      imports = [
        inputs.catppuccin.homeModules.catppuccin
        # inputs.illogical-impulse.homeManagerModules.default
        # inputs.illogical-impulse.homeManagerModules.audio
        # inputs.illogical-impulse.homeManagerModules.backlight
        # inputs.illogical-impulse.homeManagerModules.basic
        # inputs.illogical-impulse.homeManagerModules.bibata-cursor
        # inputs.illogical-impulse.homeManagerModules.fonts-themes
        # inputs.illogical-impulse.homeManagerModules.hyprland
        # inputs.illogical-impulse.homeManagerModules.kde
        # inputs.illogical-impulse.homeManagerModules.microtex  
        # inputs.illogical-impulse.homeManagerModules.oneui4-icons
        # inputs.illogical-impulse.homeManagerModules.portal
        # inputs.illogical-impulse.homeManagerModules.python
        # inputs.illogical-impulse.homeManagerModules.screencapture
        # inputs.illogical-impulse.homeManagerModules.toolkit
        # inputs.illogical-impulse.homeManagerModules.widgets
        ./vscode.nix
        ./git.nix
        ./nushell.nix
        ./starship.nix
        ./kitty.nix
	      ./lazyvim/lazyvim.nix
        # ./rofi.nix
        # ./waybar/waybar.nix # Disabled - qs (quickshell) is used instead
        # ./hypr/hypr.nix # Disabled - using hypr-custom.nix with dots-hyprland instead
        # ./hypr-custom.nix # dots-hyprland customization examples (monitor config, keybindings, etc.)
        ./wlogout/wlogout.nix
      ];

      home.packages = with pkgs; [
        osu-lazer-bin
        tidal-hifi
        proton-pass
        #discord
        vesktop
        kdePackages.filelight
        qimgv
        orca-slicer
        qbittorrent-enhanced
        godotPackages_4_5.godot
      ];

      home.sessionVariables = {
        EDITOR = "nvim";
      };

      # no touchy
      home.stateVersion = "25.05";
    };
}
