{ ... }:
{
  # PATTERN 1: NixOS Module (Cleanest)
  # Use this for system-level configuration
  flake.modules.nixos.my-module-name = {
    services.hello.enable = true;
  };

  # PATTERN 2: Home Manager Module
  # Use this for user-level configuration
  flake.modules.homeManager.my-module-name = {
    programs.git.enable = true;
  };

  # PATTERN 3: Module needing pkgs/lib/config
  # Use a function when you need access to these arguments
  flake.modules.nixos.advanced-module =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      environment.systemPackages = [ pkgs.hello ];
      services.hello.enable = lib.mkDefault true;
    };

  # PATTERN 4: Grouped Modules
  # You can define multiple modules in one file
  flake.modules.nixos = {
    client = {
      networking.firewall.enable = true;
    };

    server = {
      services.nginx.enable = true;
    };
  };
}
