_:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        extraOptions = {
          AddKeysToAgent = "yes";
          IdentityFile = "~/.ssh/id_ed25519";
        };
      };
      "homeserver" = {
        hostname = "192.168.1.83";
        user = "vee";
        identityFile = "~/.ssh/homeserver";
        identitiesOnly = true;
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github.com-v33";
      };
    };
  };
}
