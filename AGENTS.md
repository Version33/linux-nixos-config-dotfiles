# AGENTS.md - NixOS Configuration Guide for AI Coding Agents

This document provides guidelines for AI coding agents working on this NixOS configuration repository.

## Repository Overview

This is a flake-based NixOS configuration using flake-parts and import-tree for automatic module discovery.
The system is named "k0or" and uses the modular structure for organizing NixOS and home-manager configurations.

## Build/Test/Lint Commands

### Building and Switching

```bash
# Build and switch to new configuration (recommended - uses nom for better output)
just switch

# Build without switching (test configuration validity)
just build

# Build and test without making it default boot option
just test

# Plain rebuild (fallback without nom)
sudo nixos-rebuild switch --flake .#k0or
```

### Formatting and Linting

```bash
# Format all .nix files (uses nixfmt)
just fmt

# Check for code issues with statix (linter)
just check

# Find and report unused code
just deadcode

# Check flake validity (uses nom for better output)
just flake-check

# Run all checks in sequence
just fmt && just check && just deadcode
```

### Development Environment

```bash
# Enter development shell (includes all dev tools)
nix develop

# Auto-load with direnv (recommended)
direnv allow  # One-time setup
# Environment auto-loads when entering directory
```

### Flake Management

```bash
# Update all flake inputs
just update

# Update specific input
just update-input nixpkgs

# Show flake metadata
just flake-info

# Show what would be built/downloaded
just dry-run

# Show diff between current and new config
just diff
```

### Maintenance

```bash
# Clean up old generations (keeps last 30 days)
just clean

# List all system generations
just generations

# Optimize nix store (deduplicate files)
just optimize

# Show nix store disk usage
just disk-usage
```

### Git Operations

```bash
# Quick commit with message
just commit "feat: add new feature"

# Commit and switch in one command
just quick "fix: update config"
```

## Project Structure

```
/home/vee/nixos/
├── flake.nix              # Auto-generated from modules/flake.nix (DO NOT EDIT)
├── default.nix            # Entry point using flake-parts
├── hardware-configuration.nix  # Hardware-specific config (DO NOT EDIT)
├── justfile               # Command runner recipes
├── .envrc                 # Direnv configuration
└── modules/
    ├── flake.nix          # Core flake configuration (EDIT THIS, not root flake.nix)
    ├── audio/             # Audio production setup
    ├── boot/              # Boot configuration (secure boot, etc.)
    ├── desktop/           # Desktop environment (KDE/GNOME)
    ├── development/       # Dev tools, languages, LSPs
    ├── gaming/            # Gaming-related packages and config
    ├── hardware/          # Hardware-specific settings
    ├── home/              # Home-manager modules
    ├── network/           # Network, VPN, firewall, DNS
    ├── services/          # System services
    ├── system/            # Core system settings
    └── users/             # User account definitions
```

## Code Style Guidelines

### File Organization

- Each module is a `.nix` file that follows the pattern:
  ```nix
  { ... }:
  {
    flake.modules.nixos.module-name = { pkgs, ... }: {
      # NixOS configuration here
    };
  }
  ```

- Home-manager modules use:
  ```nix
  { ... }:
  {
    flake.modules.homeManager.module-name = { pkgs, ... }: {
      # Home-manager configuration here
    };
  }
  ```

- Files starting with underscore (e.g., `_rust.nix`) are disabled modules or package derivations
- Files named `hardware-configuration.nix` should never be edited (auto-generated)

### Formatting Rules

- **Use nixfmt for all formatting** - Run `just fmt` before committing
- Indentation: 2 spaces (enforced by nixfmt)
- Line length: Let nixfmt handle wrapping
- Comments: Use `#` for single-line comments, placed above the code they describe

### Naming Conventions

- Module names: kebab-case (e.g., `nix-settings.nix`, `auto-upgrade.nix`)
- Attribute names: camelCase for options, kebab-case for packages
- Variables: Use descriptive names (e.g., `plugin-installer`, not `pi`)
- Private variables: Prefix with underscore (e.g., `_version`)

### Import and Dependencies

- Minimal imports: Only import what you need `{ pkgs, ... }:` or `{ pkgs, lib, ... }:`
- Never import specific packages at module level - use `pkgs.packageName`
- Use `with pkgs;` inside lists for brevity:
  ```nix
  environment.systemPackages = with pkgs; [
    git
    neovim
  ];
  ```

### Comments and Documentation

- Add comments explaining WHY, not WHAT (code should be self-explanatory)
- Use section headers with equals signs for major sections:
  ```nix
  # ============================================================================
  # Section Name
  # ============================================================================
  ```
- Use dashes for subsections:
  ```nix
  # --------------------------------------------------------------------------
  # Subsection Name
  # --------------------------------------------------------------------------
  ```
- Include references for complex configurations:
  ```nix
  # Reference: https://nix.dev/guides/recipes/add-binary-cache
  ```

### Module Structure

Organize module content in this order:
1. Imports (if any)
2. Options/settings
3. Packages
4. Services
5. Comments explaining configuration choices

Example:
```nix
{ ... }:
{
  flake.modules.nixos.example = { pkgs, ... }: {
    # Configure service settings
    services.example = {
      enable = true;
      setting = "value";
    };

    # Install related packages
    environment.systemPackages = with pkgs; [
      package1
      package2
    ];
  };
}
```

### Error Handling

- Prefer options that fail explicitly over silent failures
- Use assertions when dependencies are required:
  ```nix
  assertions = [{
    assertion = config.programs.example.enable;
    message = "Example must be enabled for this feature";
  }];
  ```

### Types and Values

- Use explicit booleans: `true`/`false` (not strings)
- Use proper types for values (integers as numbers, not strings)
- Use `lib.mkDefault` for values that should be overridable
- Quote strings with spaces or special characters

## Testing

There are no automated tests in this repository. Testing is done by:
1. Building the configuration: `just build`
2. Checking with statix: `just check`
3. Testing live system: `just test` (applies without making default)
4. Verifying after switch: Check system functionality manually

## Important Files

- `modules/flake.nix` - Core flake configuration (**EDIT THIS** to modify flake inputs)
- `flake.nix` - Auto-generated, regenerated with `nix run .#write-flake` (**DO NOT EDIT**)
- `justfile` - Contains all common commands
- `.envrc` - Direnv config for auto-loading dev environment

## Special Considerations

- This system uses lanzaboote for secure boot
- Username is `vee`, shell is `nushell`
- System hostname is `k0or`
- Uses unstable nixpkgs channel
- Auto-optimizes store (deduplication enabled)
- treefmt-nix handles formatting configuration

## Adding New Modules

1. Create new `.nix` file in appropriate `modules/` subdirectory
2. Follow the module pattern shown in Code Style Guidelines
3. Run `just fmt` to format
4. Test with `just build` before switching
5. Commit with descriptive message using conventional commits format

Modules are automatically discovered by import-tree, no need to manually import them.
