{ ... }:

{
  home.shell.enableNushellIntegration = true;
  programs.nushell = {
    enable = true;
    shellAliases = {
      nix-shell = "nix-shell --command nu";
    };
    settings = {
      show_banner = false;
    };
    # configFile.text = "fastfetch";
  };
}
