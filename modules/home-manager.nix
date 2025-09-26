{ config, pkgs, ... }:

{
  home-manager.users.vee =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;
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
        vscode = {
          enable = true;
          package = pkgs.vscodium;
          profiles.default = {
            extensions = with pkgs.vscode-extensions; [
              vscodevim.vim
              visualstudioexptteam.vscodeintellicode
              christian-kohler.path-intellisense
              jnoortheen.nix-ide
              jeff-hykin.better-nix-syntax
              formulahendry.code-runner
            ];
          };
        };

        git = {
          enable = true;
          userName = "Version33";
          userEmail = "vee@versionthirtythr.ee";
          aliases = {
            pu = "push";
            co = "checkout";
            cm = "commit";
          };
          extraConfig = {
            init.defaultBranch = "main";
            safe.directory = "/etc/nixos";
          };
        };

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
