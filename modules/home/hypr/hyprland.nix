{ ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    # package = pkgs.hyprland; # You can specify a custom package here

    # extraConfig = builtins.readFile ./monitor.conf;
    # The above is a simple way to include a raw config file.
    # However, the "Nix way" is to import another Nix file.
    # See the note on monitors below this code block.

    settings = let
      # See https://wiki.hyprland.org/Configuring/Keywords/
      # Set programs that you use
      mainMod = "SUPER";
      terminal = "kitty";
      fileManager = "dolphin";
      menu = "rofi -show drun";
      browser = "firefox";
      notes = "obsidian";
      editor = "code";
      editor-alt = "subl";
      colorPicker = "hyprpicker";
    in {
      monitor = [
        "DP-2, 1920x1080@165, -1920x-300, 1"
        "DP-3, 1920x1080@144, 0x0, 1"
        "HDMI-A-1, 1920x1080@59, 1920x-400, 1, transform, 3"
      ];
      # Autostart necessary processes
      exec-once = [
      #   "/usr/lib/polkit-kde-authentication-agent-1" # Polkit to manage passwords
      #   "/usr/bin/dunst"
        "waybar" # topbar
      #   "swww-daemon" # wallpaper
      #   "swww img ~/.config/assets/backgrounds/cat_leaves.png --transition-fps 255 --transition-type outer --transition-duration 0.8"
      #   "wl-paste --type text --watch cliphist store" # clipboard
      #   "wl-paste --type image --watch cliphist store"
      #   "hypridle"
      #   "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      #   "${terminal}"
      #   "nm-applet"
      #   "hyprpaper"
        "tidal-hifi"
        "discord"
      ];

      # Look and Feel
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgb(8aadf4) rgb(24273A) rgb(24273A) rgb(8aadf4) 45deg";
        "col.inactive_border" = "rgb(24273A) rgb(24273A) rgb(24273A) rgb(27273A) 45deg";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        blur = {
          enabled = true;
          size = 3;
          passes = 3;
          new_optimizations = true;
          vibrancy = 0.1696;
          ignore_opacity = true;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {}; # Empty in your config

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vrr = 0;
      };

      # Input
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = -0.7;
        touchpad = {
          natural_scroll = true;
        };
      };

      # Per-device config
      # device = [{
      #   name = "epic-mouse-v1";
      #   sensitivity = -0.5;
      # }];

      # Keybindings
      bind = [
        "${mainMod}, T, exec, ${terminal}"
        "${mainMod}, B, exec, ${browser}"
        "${mainMod}, O, exec, ${notes}"
        "${mainMod}, C, exec, ${editor}"
        "${mainMod}, S, exec, ${editor-alt}"
        "${mainMod}, Q, killactive,"
        "${mainMod}, M, exit,"
        "${mainMod}, F, fullscreen"
        "${mainMod}, W, togglefloating,"
        "${mainMod}, J, togglesplit,"
        "${mainMod}, Space,exec, ${menu}"

        "SUPER, E, exec, jome -d | wl-copy"

        # Move focus
        "${mainMod}, left, movefocus, l"
        "${mainMod}, right, movefocus, r"
        "${mainMod}, up, movefocus, u"
        "${mainMod}, down, movefocus, d"

        # Switch workspaces
        "${mainMod}, 1, workspace, 1"
        "${mainMod}, 2, workspace, 2"
        "${mainMod}, 3, workspace, 3"
        "${mainMod}, 4, workspace, 4"
        "${mainMod}, 5, workspace, 5"
        "${mainMod}, 6, workspace, 6"
        "${mainMod}, 7, workspace, 7"
        "${mainMod}, 8, workspace, 8"
        "${mainMod}, 9, workspace, 9"
        "${mainMod}, 0, workspace, 10"

        # Move active window to a workspace
        "${mainMod} SHIFT, 1, movetoworkspace, 1"
        "${mainMod} SHIFT, 2, movetoworkspace, 2"
        "${mainMod} SHIFT, 3, movetoworkspace, 3"
        "${mainMod} SHIFT, 4, movetoworkspace, 4"
        "${mainMod} SHIFT, 5, movetoworkspace, 5"
        "${mainMod} SHIFT, 6, movetoworkspace, 6"
        "${mainMod} SHIFT, 7, movetoworkspace, 7"
        "${mainMod} SHIFT, 8, movetoworkspace, 8"
        "${mainMod} SHIFT, 9, movetoworkspace, 9"
        "${mainMod} SHIFT, 0, movetoworkspace, 10"

        # Special workspace (scratchpad)
        "${mainMod} SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces
        "${mainMod}, mouse_down, workspace, e+1"
        "${mainMod}, mouse_up, workspace, e-1"

        # Clipboard
        "SUPER, V, exec, cliphist list | tofi -c ~/.config/tofi/configV | cliphist decode | wl-copy"

        # Colour Picker
        "${mainMod}, P, exec, ${colorPicker} | wl-copy"

        # Screen locking
        "SUPER, L, exec, hyprlock"

        # wlogout
        "SUPER, ESCAPE, exec, wlogout"

        # waybar
        "Ctrl, Escape, exec, pkill waybar || waybar"

        # Screenshot
        ", Print, exec, grimblast --notify copysave screen"
        "SUPER, Print, exec, grimblast --notify copysave active"
        "SUPER ALT, Print, exec, grimblast --notify copysave area"

        # Volume and Media Control
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioMicMute, exec, pamixer --default-source -m"
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        # Screen brightness
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "${mainMod}, mouse:272, movewindow"
        "${mainMod}, mouse:273, resizewindow"
        "${mainMod}, Z, movewindow"
        "${mainMod}, X, resizewindow"
      ];
      
      # Resize windows with keys
      binde = [
        "${mainMod}+Shift, Right, resizeactive, 30 0"
        "${mainMod}+Shift, Left, resizeactive, -30 0"
        "${mainMod}+Shift, Up, resizeactive, 0 -30"
        "${mainMod}+Shift, Down, resizeactive, 0 30"
      ];
      
      # Window Rules
      windowrule = [
        "float, class:^(jome)$"
      ];
      
      windowrulev2 = [
        "opacity 0.90 0.90,class:^(Thorium-browser)$"
        "opacity 0.80 0.80,class:^(Code)$"
        "opacity 0.80 0.80,class:^(Arduino IDE)$"
        "opacity 0.80 0.80,class:^(dev.warp.Warp)$"
        "opacity 0.80 0.80,class:^(obsidian)$"
        "opacity 0.80 0.80,class:^(code-url-handler)$"
        "opacity 0.80 0.80,class:^(code-insiders-url-handler)$"
        "opacity 0.80 0.80,class:^(kitty)$"
        "opacity 0.80 0.80,class:^(org.gnome.Nautilus)$"
        "opacity 0.80 0.80,class:^(org.kde.ark)$"
        "opacity 0.80 0.80,class:^(nwg-look)$"
        "opacity 0.80 0.80,class:^(qt5ct)$"
        "opacity 0.80 0.80,class:^(qt6ct)$"
        "opacity 0.80 0.80,class:^(kvantummanager)$"
        "opacity 0.80 0.70,class:^(pavucontrol)$"
        "opacity 0.80 0.70,class:^(blueman-manager)$"
        "opacity 0.80 0.70,class:^(nm-applet)$"
        "opacity 0.70 0.70,class:^(Spotify)$"
        "opacity 0.70 0.70,initialTitle:^(Spotify Free)$"
        "opacity 0.80 0.70,class:^(nm-connection-editor)$"
        "opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "opacity 0.80 0.70,class:^(polkit-gnome-authentication-agent-1)$"
        "opacity 0.80 0.70,class:^(org.freedesktop.impl.portal.desktop.gtk)$"
        "opacity 0.80 0.70,class:^(org.freedesktop.impl.portal.desktop.hyprland)$"
        "float,class:^(kvantummanager)$"
        "float,class:^(qt5ct)$"
        "float,class:^(qt6ct)$"
        "float,class:^(nwg-look)$"
        "float,class:^(org.kde.ark)$"
        "float,class:^(pavucontrol)$"
        "float,class:^(blueman-manager)$"
        "float,class:^(nm-applet)$"
        "float,class:^(nm-connection-editor)$"
        "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
      ];

      layerrule = [
        "ignorezero,tofi"
        "ignorezero, dunst"
        "blur,dunst"
      ];
    };
  };
  
  # Environment Variables
  home.sessionVariables = {
    # MOZ_ENABLE_WAYLAND = "1";

    # Nvidia
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";

    # QT
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_STYLE_OVERRIDE = "kvantum";

    # Toolkit Backend
    GDK_BACKEND = "wayland,x11,*";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";

    # XDG
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };
}