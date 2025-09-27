{ ... }:

{
  home.shell.enableNushellIntegration = true;
  nushell = {
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
