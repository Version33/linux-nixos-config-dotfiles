{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Version33";
    userEmail = "vee@versionthirtythr.ee";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
    };
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };
}
