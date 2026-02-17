{
  flake.modules.nixos.media-tools =
    { pkgs, ... }:
    {
      # Image, video, and media processing tools
      environment.systemPackages = with pkgs; [
        imagemagick
        imv
        ffmpeg
        yt-dlp
        chafa
        viu
        hexyl
        mdcat
        pandoc
        tree-sitter
      ];
    };
}
