{
  flake.modules.nixos.fun-tools =
    { pkgs, ... }:
    {
      # Fun terminal tools for entertainment
      environment.systemPackages = with pkgs; [
        cmatrix
        pipes-rs
        rsclock
        cava
        figlet
      ];
    };
}
