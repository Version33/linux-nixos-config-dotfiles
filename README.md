# v33's NixOS Configuration

A declarative NixOS configuration featuring KDE Plasma, development tools, and audio production setup.

> Originally forked from [XNM1's config](https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles), heavily modified.

## Quick Start

```bash
# Build and switch to configuration
just switch

# Or manually
sudo nixos-rebuild switch --flake .#k0or

# Test build without applying
just build

# Update all inputs
just update
```

## Project Structure

```
.
├── flake.nix                 # Flake configuration and inputs
├── configuration.nix         # System state version
├── hardware-configuration.nix # Hardware-specific settings
├── justfile                  # Common commands and workflows
├── flake-parts/             # Modular flake configuration (using flake-parts)
│   ├── nixos-systems.nix   # System configurations
│   ├── dev-shell.nix       # Development environment
│   └── README.md           # Flake-parts documentation
├── modules/
│   ├── default.nix          # Module imports and organization
│   ├── home/                # Home-manager configurations
│   │   ├── home.nix        # Main home-manager setup
│   │   ├── vscode.nix      # VSCodium configuration
│   │   ├── git.nix         # Git, delta, lazygit
│   │   ├── plasma.nix      # KDE Plasma settings
│   │   └── ...
│   ├── plugins/             # Custom package definitions
│   │   ├── serum2.nix      # Audio plugin packages
│   │   └── shaperbox3.nix
│   └── optional/            # Disabled modules (available to enable)
│       ├── networking.nix
│       ├── virtualisation.nix
│       └── ...
└── .envrc                   # Direnv automatic dev environment
```

## Module Organization

Modules are organized by category in `modules/default.nix`:

- **Boot & Kernel** - Bootloader, kernel, and secure boot
- **Hardware Support** - GPU, sound, bluetooth, USB
- **System Settings** - Time, localization, environment
- **Network & Security** - Firewall and network configuration
- **System Services** - Fonts, services, maintenance
- **User Configuration** - User accounts and authentication
- **Desktop Environment** - KDE Plasma configuration
- **Development Tools** - LSP, terminal utilities, dev packages
- **Audio Production** - Audio tools and VST plugins
- **Home Manager** - User-level package and config management

## Enabling Optional Modules

Optional modules are stored in `modules/optional/`. To enable one:

1. Open `modules/default.nix`
2. Uncomment the desired module in the "Optional modules" section
3. Rebuild: `just switch`

**Available optional modules:**
- `networking.nix` - Advanced networking configuration
- `virtualisation.nix` - Docker, QEMU, VMs
- `rust.nix` - Rust development environment
- `llm.nix` - LLM tools and utilities
- `yubikey.nix` - YubiKey support
- `printing.nix` - CUPS printing support
- And more... (see `modules/optional/`)

## Development Environment

This project uses direnv for automatic environment loading.

**First-time setup:**
```bash
just switch        # Enable direnv in your system
cd /home/vee/nixos # Re-enter directory
direnv allow       # Grant permission (one-time)
```

**Tools available in dev environment:**
- `nixd` - Nix LSP server
- `nixpkgs-fmt` - Nix code formatter
- `statix` - Nix linter
- `deadnix` - Find unused code
- `nix-tree` - Visualize dependencies
- `just` - Command runner

## Common Commands

Run `just` to see all available commands. Most useful:

```bash
# Development
just fmt          # Format all nix files
just check        # Check for issues with statix
just deadcode     # Find unused code

# System Management
just switch       # Build and apply configuration
just build        # Build without applying
just dry-run      # Show what would change
just diff         # Show configuration diff

# Updates & Maintenance
just update       # Update all flake inputs
just clean        # Clean old generations (30+ days)
just generations  # List all system generations
just optimize     # Optimize nix store

# Testing
just vm           # Test configuration in VM

# Quick Workflows
just quick "message"  # Commit and switch in one command
```

## Customization

### User Configuration

Edit `modules/users.nix` to modify user accounts.

### Desktop Environment

- KDE settings: `modules/kde.nix` and `modules/home/plasma.nix`
- To switch to GNOME: Enable `modules/optional/gnome.nix`, disable `modules/kde.nix`

### Development Tools

- VSCodium: `modules/home/vscode.nix`
- Git: `modules/home/git.nix`
- Shell: `modules/home/nushell.nix`
- Terminal: `modules/home/kitty.nix`

### Hardware

- GPU: `modules/amdgpu.nix` and `modules/graphics.nix`
- Audio: `modules/sound.nix` and `modules/audio.nix`
- Bluetooth: `modules/bluetooth.nix`

## Troubleshooting

### Build Failures

```bash
# Check flake for errors
nix flake check

# Show detailed build log
nixos-rebuild build --flake .#k0or --show-trace

# Verify syntax
statix check .
```

### System Won't Boot

Boot into a previous generation from the bootloader menu, then:
```bash
# List generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Rollback
sudo nixos-rebuild switch --rollback
```

### Disk Space Issues

```bash
# Clean old generations
just clean

# Optimize store
just optimize

# Check disk usage
just disk-usage
```

### Direnv Not Loading

```bash
# Allow the directory
direnv allow

# Check status
direnv status

# Reload
direnv reload
```

## Flake Architecture

This configuration uses [flake-parts](https://flake.parts/) for modular organization.

The flake is split into focused modules in `flake-parts/`:
- `nixos-systems.nix` - System configurations
- `dev-shell.nix` - Development environment

See `flake-parts/README.md` for details on adding systems or outputs.

## Flake Inputs

- `nixpkgs` - nixos-unstable channel
- `flake-parts` - Modular flake architecture
- `home-manager` - User environment management
- `lanzaboote` - Secure Boot support
- `catppuccin` - Catppuccin theme
- `audio.nix` - Audio production tools
- `plasma-manager` - KDE Plasma configuration

## System Info

- **Host:** k0or
- **State Version:** 25.05
- **Architecture:** x86_64-linux

## License

See [LICENSE](LICENSE) file.
