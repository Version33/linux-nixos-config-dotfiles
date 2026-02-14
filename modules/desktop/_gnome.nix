{

  flake.modules.nixos.gnome =
    { ... }:
    {
      # Enable Gnome
      services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };

      # Gnome Exclude Packages
      # environment.gnome.excludePackages = (with pkgs; [
      #   gnome-tour
      # ]) ++ (with pkgs.gnome; [
      #       gnome-terminal
      #       gedit # text editor
      #       epiphany # web browser
      #       geary # email reader
      #       tali # poker game
      #       iagno # go game
      #       hitori # sudoku game
      #       atomix # puzzle game
      # ]);
    };

}
