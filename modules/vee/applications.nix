{
  flake.modules.nixos.applications =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # gaming & entertainment
        osu-lazer-bin
        tidal-hifi
        prismlauncher
        obs-studio

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
        blender

        # audio
        lsp-plugins
      ];

      nixpkgs.config.allowUnfree = true;
    };
}
