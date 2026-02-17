{

  flake.modules.nixos.vee =
    { self, pkgs, ... }:
    {
      environment.shells = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.nushell
      ];

      # Define a user account. Don't forget to set a password with 'passwd'.
      users.users.vee = {
        isNormalUser = true;
        description = "vee";
        initialPassword = "";
        shell = self.packages.${pkgs.stdenv.hostPlatform.system}.nushell;
        extraGroups = [
          "networkmanager"
          "input"
          "wheel"
          "video"
          "realtime"
          "audio"
          "tss"
          "plugdev"
        ];
      };

      programs = {
        firefox.enable = true;
        steam.enable = true;

        # GameMode for optimizing gaming performance
        gamemode = {
          enable = true;
          settings = {
            general = {
              renice = 10;
            };
            # Custom scripts can be added here
            # gpu = {
            #   apply_gpu_optimisations = "accept-responsibility";
            #   gpu_device = 0;
            #   amd_performance_level = "high";
            # };
          };
        };
      };

      # Increase runtime directory size for large tmpfs operations (default is 10% of RAM)
      # Note: Power button behavior is configured in desktop/kde.nix with other logind settings
      services.logind.settings.Login.RuntimeDirectorySize = "8G";
    };

}
