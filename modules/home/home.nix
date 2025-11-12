{ pkgs, inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.catppuccin.nixosModules.catppuccin
  ];

  home-manager.users.vee = {
    home.username = "vee";
    home.homeDirectory = "/home/vee";
    nixpkgs.config.allowUnfree = true;

    imports = [
      inputs.catppuccin.homeModules.catppuccin
      inputs.plasma-manager.homeModules.plasma-manager
      ./vscode.nix
      ./git.nix
      ./nushell.nix
      ./starship.nix
      ./kitty.nix
      ./lazyvim/lazyvim.nix
      ./plasma.nix
      ./yabridge.nix
      ./lsp-plugins.nix
      ./ssh.nix
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
      claude-code
      opencode
      # inputs.claude-desktop.packages.${pkgs.system}.claude-desktop-with-fhs
      # gemini-cli
      lsp-plugins
      prismlauncher
      orca-slicer-nightly # Nightly build with H2D/H2S printer support
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    # no touchy
    home.stateVersion = "25.05";
  };
}
