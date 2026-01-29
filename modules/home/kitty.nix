{ ... }:
{

  flake.modules.homeManager.kitty = _: {
    programs.kitty = {
      enable = true;
      enableGitIntegration = true;
      themeFile = "Catppuccin-Mocha";
      font = {
        name = "JetBrainsMono Nerd Font Mono";
        size = 13;
      };
      settings = {
        # Enable remote control for opencode.nvim integration
        allow_remote_control = "yes";
        listen_on = "unix:@mykitty";
      };
    };
  };

}
