{
  flake.modules.nixos.applications =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # gaming & entertainment
        osu-lazer-bin
        tidal-hifi
        prismlauncher

        # communication
        vesktop
        element-desktop

        # utilities
        proton-pass
        kdePackages.filelight
        qimgv
        qbittorrent-enhanced

        # development & creative
        godotPackages_4_6.godot

        # audio
        lsp-plugins
      ];

      nixpkgs.config.allowUnfree = true;
    };
}
