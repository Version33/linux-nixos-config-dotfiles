# Hyprland Integration via dots-hyprland Flake

This document explains the integration of the dots-hyprland flake into this NixOS configuration.

## Changes Made

### 1. Enabled dots-hyprland Flake Input
- **File**: `flake.nix`
- **Change**: Added the flake input `dots-hyprland.url = "github:version33/dots-hyprland-nixos"`

### 2. Integrated dots-hyprland in Home Manager
- **File**: `modules/home/home.nix`
- **Change**: Added `inputs.dots-hyprland.homeModules.default` to the home-manager imports list
- **Purpose**: Provides base Hyprland configuration from dots-hyprland

### 3. Created Customization Examples
- **File**: `modules/home/hypr-custom.nix` (new file)
- **Purpose**: Demonstrates how to customize Hyprland on top of dots-hyprland base configuration
- **Includes**: Monitor configuration examples, keybinding overrides, workspace settings, and more
- **Note**: Does not import dots-hyprland directly to avoid infinite recursion; that's done in home.nix

### 3. Re-enabled System-level Hyprland
- **File**: `flake.nix`
- **Change**: Kept `./modules/hyprland.nix` enabled for system-level packages (pyprland, kitty, etc.)
- **Reason**: System packages still needed; only the home-manager Hyprland config uses dots-hyprland

### 4. Updated Home Manager Imports
- **File**: `modules/home/home.nix`
- **Changes**: 
  - Added `inputs.dots-hyprland.homeModules.default` to imports list
  - Added `./hypr-custom.nix` import for customization examples
  - Disabled local `./hypr/hypr.nix`
- **Reason**: Use dots-hyprland as the base configuration with customization options

## Conflicts Resolved

### Already Disabled Conflicts
The following were already commented out in the configuration and remain disabled:
- `./modules/gnome.nix` - Would enable GNOME desktop and GDM (conflicts with greetd and Hyprland)
- `./modules/theme.nix` - Commented out, might contain theme settings

### Compatible Components
These components are compatible with Hyprland and remain enabled:
- **Display Manager**: `greetd` with `tuigreet` configured to launch Hyprland via uwsm
- **Graphics**: AMD GPU drivers (work with both X11 and Wayland)
- **Services**: 
  - dbus with xfce.xfconf and gnome2.GConf (for compatibility with some apps)
  - dconf (required by many applications)
  - Wayland-specific utilities (grim, slurp, wl-clipboard, etc.)

### Environment Variables
The following environment variables are set for Hyprland compatibility:
- **System Level** (in `modules/hyprland.nix`, now re-enabled):
  - `NIXOS_OZONE_WL = "1"` - Enables Wayland support for Electron apps
  - `WLR_NO_HARDWARE_CURSORS = "1"` - Fixes cursor issues on some hardware

- **Home Level**: Can be customized in `modules/home/hypr-custom.nix` using the `env` setting
  - Examples for Nvidia-specific variables, Qt/QT variables, XDG variables are provided in the file
  - Qt/QT variables for Wayland
  - XDG variables for Hyprland

**Note**: The dots-hyprland flake should provide these environment variables. If issues arise, these may need to be re-enabled in `modules/environment-variables.nix`.

## Remaining Manual Verification Needed

1. **Check dots-hyprland flake structure**: Ensure it provides:
   - `homeModules.default` for home-manager-level Hyprland settings
   - Required environment variables and base configuration

2. **Customize your setup**: Edit `modules/home/hypr-custom.nix` to:
   - Configure your monitors (see detailed examples in the file)
   - Adjust keybindings, workspaces, and window rules as needed
   - Override any settings from dots-hyprland base configuration

3. **Rofi**: Still configured locally in:
   - `modules/home/rofi.nix`
   
   If dots-hyprland provides its own rofi config, this may conflict.

4. **Waybar**: Disabled in favor of qs (quickshell) which is provided by dots-hyprland.

5. **wlogout**: Still configured in `modules/home/wlogout/wlogout.nix`

6. **Packages**: The `modules/hyprland.nix` (re-enabled) provides these packages:
   - pyprland, hyprpicker
   - lxsession (for polkit)
   - wezterm, kitty, cool-retro-term
   - starship, qutebrowser, zathura, mpv, imv
   
   These remain available as system packages.

## Testing Recommendations

1. Run `nix flake lock --update-input dots-hyprland` to fetch the flake
2. Build the configuration: `nixos-rebuild build --flake .#k0or`
3. Check for any conflicting module definitions
4. Review which packages are provided by dots-hyprland vs. local config
5. Test the system to ensure Hyprland launches properly from greetd

## Rollback Instructions

If issues arise, revert these changes:
1. In `modules/home/home.nix`:
   - Remove `./hypr-custom.nix` import
   - Uncomment `./hypr/hypr.nix`
   - Optionally uncomment `./waybar/waybar.nix` if not using qs
2. Delete `modules/home/hypr-custom.nix`
3. In `flake.nix`:
   - Comment out `./modules/hyprland.nix` if you want to disable system-level Hyprland

## Fallback Configuration

A fallback configuration module has been created at `modules/hyprland-fallback.nix`. This module contains commented-out packages and settings that were previously in `modules/hyprland.nix`.

**When to use**: Enable this module (by uncommenting it in `flake.nix`) if:
- The dots-hyprland flake doesn't provide required packages
- You need additional Hyprland utilities not included in dots-hyprland
- You want to supplement dots-hyprland's configuration with local settings

**How to enable**: Add to `flake.nix` modules list:
```nix
./modules/hyprland-fallback.nix
```

Then uncomment the packages or settings you need in that file.
