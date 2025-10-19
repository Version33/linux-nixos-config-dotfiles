{ pkgs, ... }:

{
  # Configure Plasma using plasma-manager

  # Enable Catppuccin theme for Plasma
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  home.packages = with pkgs; [
    catppuccin-kde
    catppuccin-cursors.mochaDark
    catppuccin-papirus-folders
  ];

  programs.plasma = {
    enable = true;

    workspace = {
      # Set to Catppuccin Mocha theme
      colorScheme = "CatppuccinMocha";

      # Use Papirus Dark icons
      iconTheme = "Papirus-Dark";

      # Set cursor theme
      cursor = {
        theme = "catppuccin-mocha-dark-cursors";
      };
    };

    # Configure panel with 24-hour clock
    panels = [
      {
        location = "bottom";
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          {
            digitalClock = {
              time = {
                format = "24h";
                showSeconds = "onlyInTooltip";
              };
              date = {
                enable = true;
                format = "isoDate";
              };
            };
          }
        ];
      }
    ];

    # Configure locale for 24-hour time
    configFile = {
      "plasma-localerc"."Formats" = {
        LANG = "en_US.UTF-8";
        LC_TIME = "C.UTF-8";
        useDetailed = true;
      };
    };
  };
}
