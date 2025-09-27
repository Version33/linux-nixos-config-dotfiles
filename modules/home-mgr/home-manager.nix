{ config, pkgs, ... }:

{
  home-manager.users.vee =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;
      imports = [
        ./vscode.nix
        ./git.nix
      ];
      home.packages = with pkgs; [
        tidal-hifi
        discord
        qimgv
        orca-slicer
      ];
      home.shell.enableNushellIntegration = true;
      programs = {
        bash.enable = true;
        starship.enableNushellIntegration = true;
        nushell = {
          enable = true;
          shellAliases = {
            nix-shell = "nix-shell --command nu";
          };
          settings = {
            show_banner = false;
          };
          configFile.text = "fastfetch";
        };
        starship = {
          enable = true;
        };

      };
      # no touchy
      home.stateVersion = "25.05";
    };
}
