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
        ./vscode.nix
        ./git.nix
        ./nushell.nix
        ./starship.nix
        ./kitty.nix
	      ./lazyvim/lazyvim.nix
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
