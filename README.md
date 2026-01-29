# v33's NixOS Configuration

A NixOS configuration.

> Originally forked from [XNM1's config](https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles), heavily modified.

```bash
# Build and switch to configuration (uses nom for better output)
just switch

# Or manually (plain output)
sudo nixos-rebuild switch --flake .#k0or

# Test build without applying (uses nom for better output)
just build

# Update all inputs
just update
```
