{ ... }:

{
  home-manager.users.vee =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;
      imports = [
        ./vscode.nix
        ./git.nix
        ./nushell.nix
        ./starship.nix
      ];
      home.packages = with pkgs; [
        tidal-hifi
        discord
        qimgv
        orca-slicer
      ];
      
      programs = {
        
        

      };
      # no touchy
      home.stateVersion = "25.05";
    };
}
