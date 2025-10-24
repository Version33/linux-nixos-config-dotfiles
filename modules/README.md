# Module Development Guide

This directory contains all NixOS system configuration modules.

## Module Structure

All modules should follow this standard structure:

1. **Header Comment** - Document the module's purpose and features
2. **Function Signature** - Accept standard NixOS module arguments
3. **Imports** - Import any sub-modules
4. **Options** - Define any custom options (if applicable)
5. **Configuration** - The actual configuration code

See `TEMPLATE.nix` for a complete example.

## Creating a New Module

1. Copy the template:
   ```bash
   cp modules/TEMPLATE.nix modules/category/my-new-module.nix
   ```

2. Edit the header to describe your module:
   ```nix
   ##############################################################################
   # My New Module
   #
   # Purpose: Configure my new feature
   # Features:
   #   - Does something useful
   #   - Enables important functionality
   ##############################################################################
   ```

3. Add your configuration code

4. Import it in `modules/default.nix`:
   ```nix
   imports = [
     # ... other modules
     ./category/my-new-module.nix
   ];
   ```

5. Test and rebuild:
   ```bash
   just build   # Test first
   just switch  # Apply if build succeeds
   ```

## Module Organization

Modules are organized into category directories:

- **boot/** - Bootloader, kernel, and secure boot configuration
- **hardware/** - GPU, graphics, sound, bluetooth, USB, and other hardware
- **system/** - Core system settings (time, nix, i18n, environment, VM)
- **network/** - Networking, firewall, DNS, SSH, and VPN
- **desktop/** - KDE, GNOME, display manager, and theme configuration
- **development/** - LSP, programming languages, tools, and utilities
- **audio/** - Audio production tools, VST plugins, and bridges
- **users/** - User accounts and configuration
- **services/** - System services, fonts, printing, and security
- **home/** - Home Manager user-level configurations

Place your new module file in the appropriate category directory.

## Optional Modules

Optional modules are available within their respective category directories but commented out in `default.nix`.

To enable an optional module:
1. Edit `default.nix`
2. Uncomment the module path (e.g., `# ./development/rust.nix` → `./development/rust.nix`)
3. Rebuild: `just switch`

To disable an active module:
1. Comment it out in `default.nix`
2. Rebuild: `just switch`

## Best Practices

### Documentation
- Always include a header comment
- Document non-obvious configuration choices
- List all major features
- Note any prerequisites or setup steps

### Code Style
- Use consistent indentation (2 spaces)
- Format with `nixpkgs-fmt` before committing
- Group related settings together
- Add inline comments for complex logic

### Package Management
- Prefer system packages (`environment.systemPackages`) for system-wide tools
- Use home-manager packages for user-specific applications
- Document why each package is needed with inline comments

### Testing
- Always test with `just build` before `just switch`
- Use `just diff` to see what will change
- Test in a VM with `just vm` for major changes
- Keep backups or know how to rollback

### Dependencies
- Minimize cross-module dependencies
- Use `config` parameter to check other module settings if needed
- Document any module dependencies in the header

## Common Patterns

### Conditional Configuration
```nix
{ config, lib, ... }:
{
  config = lib.mkIf config.services.xserver.enable {
    # Only apply if X server is enabled
  };
}
```

### Creating Options
```nix
{ lib, ... }:
{
  options.myconfig.feature = lib.mkEnableOption "my feature";

  config = lib.mkIf config.myconfig.feature {
    # Configuration when enabled
  };
}
```

### Importing Other Inputs
```nix
{ inputs, ... }:
{
  imports = [
    inputs.some-flake.nixosModules.default
  ];
}
```

## File Naming

- Use lowercase with hyphens: `my-module.nix`
- Name should describe the module's purpose
- Avoid generic names like `misc.nix` or `other.nix`
- Group related functionality in one module when sensible

## Getting Help

- NixOS Manual: https://nixos.org/manual/nixos/stable/
- NixOS Options Search: https://search.nixos.org/options
- Home Manager Options: https://nix-community.github.io/home-manager/options.xhtml
- Run `just check` to find issues
- Run `just fmt` to format code

## Troubleshooting

### Module Not Loading
- Check it's imported in `default.nix`
- Verify syntax with `nix flake check`
- Look for typos in the file path

### Conflicting Options
- Check if another module sets the same option
- Use `lib.mkForce` to override if necessary
- Consider using `lib.mkDefault` for default values

### Build Errors
- Read the error message carefully
- Use `--show-trace` flag for detailed errors
- Check NixOS options documentation for correct syntax
