{ pkgs, ... }:

{
  # Systemd services setup
  # systemd.packages = with pkgs; [
  #   auto-cpufreq # Automatic CPU speed & power optimizer for Linux # laptop power optimization
  # ];

  # Enable Services
  # programs.direnv.enable = true; # Shell extension that manages your environment.
  # services.upower.enable = true; # D-Bus service for power management.
  # programs.fish.enable = true;
  programs.dconf.enable = true;
  services.dbus = {
    enable = true;
    implementation = "broker";
    packages = with pkgs; [
      xfce.xfconf
      gnome2.GConf
    ];
  };
  services.mpd.enable = true; # Flexible, powerful daemon for playing music.
  programs.xfconf.enable = true; # Xfce configuration storage system
  services.tumbler.enable = true; # D-Bus thumbnailer service
  services.fwupd.enable = true; # DBus service that allows applications to update firmware.
  # services.auto-cpufreq.enable = true;
  # services.gnome.core-shell.enable = true;
  # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  hardware.opentabletdriver.enable = true;

  environment.systemPackages = with pkgs; [
    at-spi2-atk # Assistive Technology Service Provider Interface protocol definitions and daemon for D-Bus.
    qt6.qtwayland # Cross-platform application framework for C++
    psi-notify # Alert on system resource saturation.
    # poweralertd # UPower-powered power alerter.
    playerctl # Command-line utility and library for controlling media players that implement MPRIS.
    psmisc # Set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
    grim # Grab images from a Wayland compositor.
    slurp # Select a region in a Wayland compositor.
    imagemagick # Software suite to create, edit, compose, or convert bitmap images.
    swappy # Wayland native snapshot editing tool, inspired by Snappy on macOS.
    ffmpeg_6-full # Complete, cross-platform solution to record, convert and stream audio and video.
    wl-screenrec # High performance wlroots screen recording, featuring hardware encoding.
    wl-clipboard # Command-line copy/paste utilities for Wayland.
    wl-clip-persist # Keep Wayland clipboard even after programs close.
    cliphist # Wayland clipboard manager.
    xdg-utils # Set of command line tools that assist applications with a variety of desktop integration tasks.
    wtype # xdotool type for wayland.
    wlrctl # Command line utility for miscellaneous wlroots Wayland extensions.
    dunst # Lightweight and customizable notification daemon.
    avizo # Neat notification daemon for Wayland.
    gifsicle # Command-line tool for creating, editing, and getting information about GIF images and animations.
    hyprshot # Utility to easily take screenshots in Hyprland using your mouse.
  ];
}
