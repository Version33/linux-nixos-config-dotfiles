{ pkgs, ... }:

{
  # Setup Env Variables
  # environment.variables.SPOTIFY_PATH = "${pkgs.spotify}/";
  environment.variables.JDK_PATH = "${pkgs.jdk}/";
  # environment.variables.NODEJS_PATH = "${pkgs.nodePackages_latest.nodejs}/";
}
