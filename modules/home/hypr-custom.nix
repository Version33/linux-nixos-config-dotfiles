{ inputs, ... }:

{
  # Import dots-hyprland home-manager module
  # This provides the base Hyprland configuration from the dots-hyprland flake
  imports = [
    inputs.dots-hyprland.homeModules.default or {}
  ];

  # Example: Customize Hyprland configuration
  # The dots-hyprland flake provides a base configuration, and you can override
  # or extend it using wayland.windowManager.hyprland.settings
  
  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {
      # Example: Monitor Configuration
      # Configure your monitors with resolution, position, and refresh rate
      # Format: "NAME, RESOLUTION@REFRESH, POSITION, SCALE"
      # You can find your monitor names by running: hyprctl monitors
      monitor = [
        # Example for a triple monitor setup:
        # Left monitor (DP-2): 1920x1080 at 165Hz, positioned left of center
        "DP-2, 1920x1080@165, -1920x-300, 1"
        
        # Center monitor (DP-3): 1920x1080 at 144Hz, main monitor at origin
        "DP-3, 1920x1080@144, 0x0, 1"
        
        # Right monitor (HDMI-A-1): 1920x1080 at 59Hz, rotated 90 degrees (portrait)
        # transform values: 0=normal, 1=90°, 2=180°, 3=270°
        "HDMI-A-1, 1920x1080@59, 1920x-400, 1, transform, 3"
        
        # Alternative examples:
        # Single 4K monitor: "DP-1, 3840x2160@60, 0x0, 1.5"  # 1.5x scale for better readability
        # Laptop + external: "eDP-1, 1920x1080@60, 0x0, 1" and "HDMI-A-1, 2560x1440@144, 1920x0, 1"
        # Auto-configure: "DP-1, preferred, auto, 1"
        # Disable a monitor: "HDMI-A-1, disable"
      ];

      # Example: Custom keybindings
      # Uncomment and modify as needed
      # bind = [
      #   "SUPER, T, exec, kitty"
      #   "SUPER, B, exec, firefox"
      #   "SUPER, Q, killactive,"
      # ];

      # Example: Workspace configuration
      # workspace = [
      #   "1, monitor:DP-3"    # Workspace 1 on center monitor
      #   "2, monitor:DP-2"    # Workspace 2 on left monitor
      #   "3, monitor:HDMI-A-1"  # Workspace 3 on right monitor
      # ];

      # Example: Custom window rules
      # windowrulev2 = [
      #   "float,class:^(pavucontrol)$"
      #   "workspace 2,class:^(firefox)$"
      # ];

      # Example: Environment variables
      # env = [
      #   "XCURSOR_SIZE,24"
      #   "HYPRCURSOR_SIZE,24"
      # ];
    };
  };
}
