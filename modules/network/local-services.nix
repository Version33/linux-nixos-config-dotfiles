{ config, pkgs, ... }:

{
  networking.hosts = {
    "127.0.0.1" = [
      "jellyfin.local"
      "qbittorrent.local"
      "radarr.local"
      "incus.local"
    ];
  };
}
