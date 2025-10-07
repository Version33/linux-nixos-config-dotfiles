# Integration Verification Checklist

After integrating the dots-hyprland flake, use this checklist to verify everything works properly.

## Pre-Build Checks

- [ ] Verify flake inputs are accessible
  ```bash
  nix flake metadata github:version33/dots-hyprland-nixos
  ```

- [ ] Update flake.lock to fetch the dots-hyprland flake
  ```bash
  nix flake lock --update-input dots-hyprland
  ```

## Build Checks

- [ ] Dry-run the build to check for syntax errors
  ```bash
  nixos-rebuild dry-build --flake .#k0or
  ```

- [ ] Build the configuration
  ```bash
  nixos-rebuild build --flake .#k0or
  ```

- [ ] Check for any warnings or errors in the build output
  - Pay attention to module conflicts
  - Look for missing package definitions
  - Note any deprecation warnings

## Common Issues and Solutions

### Issue: dots-hyprland flake not found or access denied
**Solution**: Ensure the repository exists and is public, or add authentication if it's private.

### Issue: Missing `nixosModules.default` output
**Solution**: Check what outputs the dots-hyprland flake provides:
```bash
nix flake show github:version33/dots-hyprland-nixos
```
Then adjust the import in `flake.nix` accordingly. For example, it might be:
- `inputs.dots-hyprland.nixosModules.hyprland`
- `inputs.dots-hyprland.nixosModule`
- Or the flake might not provide a nixosModule at all

### Issue: Missing packages (pyprland, hyprpicker, etc.)
**Solution**: Enable the fallback configuration:
1. Uncomment in `flake.nix`: `./modules/hyprland-fallback.nix`
2. Edit `modules/hyprland-fallback.nix` and uncomment needed packages

### Issue: Conflicting Hyprland configuration
**Solution**: If dots-hyprland doesn't work as expected, you can:
1. Re-enable local config: Uncomment `./modules/hyprland.nix` in `flake.nix`
2. Remove dots-hyprland: Comment out `inputs.dots-hyprland.nixosModules.default`
3. Re-enable home config: Uncomment `./hypr/hypr.nix` in `modules/home/home.nix`

### Issue: Waybar or Rofi conflicts
**Solution**: If dots-hyprland provides its own waybar/rofi configs:
1. Comment out `./waybar/waybar.nix` in `modules/home/home.nix`
2. Comment out `./rofi.nix` in `modules/home/home.nix`

## Post-Build Verification

- [ ] Switch to the new configuration
  ```bash
  sudo nixos-rebuild switch --flake .#k0or
  ```

- [ ] Reboot the system
  ```bash
  sudo reboot
  ```

- [ ] Verify greetd/tuigreet launches properly at boot

- [ ] Log in and verify Hyprland starts via uwsm

- [ ] Test basic Hyprland functionality:
  - [ ] Super+T opens terminal
  - [ ] Super+B opens browser
  - [ ] Super+Q closes window
  - [ ] Super+[1-9] switches workspaces
  - [ ] Super key alone opens menu (rofi)

- [ ] Check if all expected applications are available:
  - [ ] Waybar (top bar)
  - [ ] Rofi (app launcher)
  - [ ] Terminal emulator (kitty/wezterm)
  - [ ] File manager (dolphin)
  
- [ ] Verify Wayland-specific features work:
  - [ ] Screenshot tools (grim + slurp)
  - [ ] Clipboard (wl-clipboard)
  - [ ] Screen recording (wl-screenrec)

## Troubleshooting Log

Use this section to note any issues encountered:

```
Date: _________________
Issue: 




Solution:



```

## Success Criteria

The integration is successful when:
- ✓ System builds without errors
- ✓ Hyprland launches from greetd
- ✓ All keybindings work as expected
- ✓ No visual glitches or artifacts
- ✓ All required applications are available
- ✓ Wayland features work properly
