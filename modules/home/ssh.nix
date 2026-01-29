{ ... }:
{

  flake.modules.homeManager.ssh = _: {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          extraOptions = {
            AddKeysToAgent = "yes";
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
  };

}
