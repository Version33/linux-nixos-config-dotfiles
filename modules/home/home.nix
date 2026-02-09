{ inputs, ... }:
{

  flake.modules.homeManager.vee =
    { pkgs, ... }:
    {
      home = {
        username = "vee";
        homeDirectory = "/home/vee";
      };
      nixpkgs.config.allowUnfree = true;

      imports = [
        inputs.catppuccin.homeModules.catppuccin
        inputs.plasma-manager.homeModules.plasma-manager
      ];

      home.packages = with pkgs; [
        osu-lazer-bin
        tidal-hifi
        proton-pass
        #discord
        vesktop
        kdePackages.filelight
        qimgv
        qbittorrent-enhanced
        godotPackages_4_5.godot
        # claude-code
        # inputs.claude-desktop.packages.${pkgs.system}.claude-desktop-with-fhs
        # gemini-cli
        lsp-plugins
        prismlauncher
        # orca-slicer-nightly # Nightly build with H2D/H2S printer support
        bambu-studio
        solo2-cli
      ];

      home.sessionVariables = {
        EDITOR = "nvim";
      };
    };

}
