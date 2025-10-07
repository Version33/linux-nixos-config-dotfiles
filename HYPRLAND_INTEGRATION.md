# Hyprland Integration via dots-hyprland Flake

This document explains the integration of the dots-hyprland flake into this NixOS configuration.

## Changes Made

### 1. Enabled dots-hyprland Flake Input
- **File**: `flake.nix`
- **Change**: Uncommented and renamed the flake input from `illogical-impulse` to `dots-hyprland`
- **Line**: `dots-hyprland.url = "github:version33/dots-hyprland-nixos";`

### 2. Integrated dots-hyprland Module
- **File**: `flake.nix`
- **Change**: Added `inputs.dots-hyprland.nixosModules.default` to the system modules list
- **Location**: After the commented `./modules/gnome.nix` line

### 3. Disabled Local Hyprland Configuration
- **File**: `flake.nix`
- **Change**: Commented out `./modules/hyprland.nix` to prevent conflicts with the dots-hyprland flake
- **Reason**: The dots-hyprland flake provides its own Hyprland system-level configuration

### 4. Disabled Home-Manager Hyprland Config
- **File**: `modules/home/home.nix`
- **Change**: Commented out `./hypr/hypr.nix` import
- **Reason**: The dots-hyprland flake should provide home-manager configuration for Hyprland

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
- **System Level** (in `modules/hyprland.nix`, now disabled):
  - `NIXOS_OZONE_WL = "1"` - Enables Wayland support for Electron apps
  - `WLR_NO_HARDWARE_CURSORS = "1"` - Fixes cursor issues on some hardware

- **Home Level** (in `modules/home/hypr/hyprland.nix`, now disabled):
  - Nvidia-specific variables (LIBVA_DRIVER_NAME, GBM_BACKEND, etc.)
  - Qt/QT variables for Wayland
  - XDG variables for Hyprland

**Note**: The dots-hyprland flake should provide these environment variables. If issues arise, these may need to be re-enabled in `modules/environment-variables.nix`.

## Remaining Manual Verification Needed

1. **Check dots-hyprland flake structure**: Ensure it provides:
   - `nixosModules.default` for system-level configuration
   - Home-manager module for user-level Hyprland settings
   - Required environment variables

2. **Rofi**: Still configured locally in:
   - `modules/home/rofi.nix`
   
   If dots-hyprland provides its own rofi config, this may conflict.

3. **Waybar**: Disabled in favor of qs (quickshell) which is provided by dots-hyprland.

3. **wlogout**: Still configured in `modules/home/wlogout/wlogout.nix`

4. **Packages**: The disabled `modules/hyprland.nix` provided these packages:
   - pyprland, hyprpicker
   - lxsession (for polkit)
   - wezterm, kitty, cool-retro-term
   - starship, qutebrowser, zathura, mpv, imv
   
   Verify these are provided by dots-hyprland or add them to `configuration.nix` if needed.

## Testing Recommendations

1. Run `nix flake lock --update-input dots-hyprland` to fetch the flake
2. Build the configuration: `nixos-rebuild build --flake .#k0or`
3. Check for any conflicting module definitions
4. Review which packages are provided by dots-hyprland vs. local config
5. Test the system to ensure Hyprland launches properly from greetd

## Rollback Instructions

If issues arise, revert these changes:
1. In `flake.nix`:
   - Uncomment `./modules/hyprland.nix`
   - Remove `inputs.dots-hyprland.nixosModules.default`
   - Comment out the dots-hyprland input
2. In `modules/home/home.nix`:
   - Uncomment `./hypr/hypr.nix`

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
