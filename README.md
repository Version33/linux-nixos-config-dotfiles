This is a heavily modified version of [this config](https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles).

Most of it's readme became irrlevant after my changes and I'm too lazy to make a similar one at the moment. I'm just happy I got it working eventually. (still need to clean up that home file and eventually nuke it all for home manager config)

Perhaps I will make this file look shiny in the future.

## 🎯 Latest Update: dots-hyprland Integration

The configuration now integrates the [dots-hyprland](https://github.com/version33/dots-hyprland-nixos) flake for Hyprland configuration management.

### 📚 Documentation

For details on the integration, see:
- **[INTEGRATION_SUMMARY.md](INTEGRATION_SUMMARY.md)** - Quick visual overview and commands
- **[HYPRLAND_INTEGRATION.md](HYPRLAND_INTEGRATION.md)** - Detailed technical documentation  
- **[VERIFICATION_CHECKLIST.md](VERIFICATION_CHECKLIST.md)** - Testing and troubleshooting guide

### 🚀 Quick Start

```bash
# Update flake inputs
nix flake lock --update-input dots-hyprland

# Build the configuration
nixos-rebuild build --flake .#k0or

# Switch to new configuration
sudo nixos-rebuild switch --flake .#k0or
```

### 🔧 Configuration Structure

- System-level Hyprland → `modules/hyprland.nix` (packages and system settings)
- Home-manager Hyprland → `modules/home/hypr-custom.nix` (dots-hyprland integration)
- Customization examples → Monitor configs, keybindings, workspaces in hypr-custom.nix
- Status bar → qs (quickshell) from dots-hyprland (waybar disabled)
- Fallback packages → `modules/hyprland-fallback.nix` (optional)
- Display manager → greetd with tuigreet + uwsm
