{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  
  home-manager.users.vee =
    { pkgs, ... }:
    {
      home.username = "vee";
      home.homeDirectory = "/home/vee";
      nixpkgs.config.allowUnfree = true;

      imports = [
        ./vscode.nix
        ./git.nix
        ./nushell.nix
        ./starship.nix
        ./kitty.nix
	      ./lazyvim/lazyvim.nix
        ./rofi.nix
        ./waybar/waybar.nix
        ./hypr/hypr.nix
      ];

      home.packages = with pkgs; [
        osu-lazer-bin
        tidal-hifi
        proton-pass
        discord
        kdePackages.filelight
        qimgv
        orca-slicer
      ];

      home.sessionVariables = {
        EDITOR = "nvim";
      };

      # no touchy
      home.stateVersion = "25.05";
    };
}
