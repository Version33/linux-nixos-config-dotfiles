_:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "homeserver" = {
        hostname = "192.168.1.83";
        user = "vee";
        identityFile = "~/.ssh/homeserver";
        identitiesOnly = true;
      };
      "github.com-v33" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github.com-v33";
        extraOptions = {
          AddKeysToAgent = "yes";
        };
      };
    };
  };
}
