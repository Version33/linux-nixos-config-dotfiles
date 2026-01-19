# NixOS Configuration - Agent Guidelines

## Project Overview

- **Type:** NixOS system configuration using flakes and flake-parts
- **Host:** `k0or` (x86_64-linux)
- **Primary user:** `vee`
- **State version:** `25.05` (never change)
- **Structure:** Modular design with organized categories in `modules/` directory

## File Structure

```
flake.nix                    # Main flake with inputs and outputs
flake.lock                   # Locked input versions
configuration.nix            # System state version only
hardware-configuration.nix   # Auto-generated - NEVER EDIT
justfile                     # Build commands and workflows
.editorconfig                # Code style configuration

flake-parts/
├── nixos-systems.nix        # System configuration definition
└── dev-shell.nix            # Development environment

modules/
├── default.nix              # Module imports (active/optional)
├── TEMPLATE.nix             # Template for new modules
├── README.md                # Module development guide
├── audio/                   # Audio production (bitwig, yabridge, VST plugins)
│   └── plugins/             # Windows VST plugin definitions (auto-discovered)
├── boot/                    # Bootloader, kernel, secure boot (lanzaboote)
├── desktop/                 # KDE Plasma 6 (active), GNOME (optional)
├── development/             # Dev tools, LSP, terminal utilities
├── gaming/                  # Steam, game launchers
├── hardware/                # AMD GPU, sound, bluetooth, graphics
├── home/                    # Home Manager configs (shell, editor, apps)
├── network/                 # Networking, firewall, DNS, tailscale
├── services/                # System services, fonts, fido2
├── system/                  # Nix settings, time, locale, env vars
└── users/                   # User account configuration
```

## Flake Inputs

| Input | Purpose |
|-------|---------|
| `nixpkgs` | Main packages (nixos-unstable) |
| `nixpkgs-opencode` | Pinned nixpkgs for specific package versions |
| `flake-parts` | Modular flake architecture |
| `lanzaboote` | UEFI Secure Boot support |
| `home-manager` | User environment management |
| `catppuccin` | System-wide Catppuccin Mocha theme |
| `plasma-manager` | Declarative KDE Plasma configuration |
| `claude-desktop` | Claude Desktop for Linux |
| `affinity` | Affinity suite (Designer, Photo, Publisher) |
| `lazyvim` | LazyVim Neovim configuration |
| `nix-flatpak` | Declarative Flatpak management |

## Build Commands

| Command | Description |
|---------|-------------|
| `just switch` | Build with nom and apply configuration |
| `just build` | Build without applying |
| `just test` | Build and test without making default |
| `just fmt` | Format all nix files with nixfmt |
| `just check` | Lint with statix |
| `just deadcode` | Find unused code with deadnix |
| `just flake-check` | Check flake with nom |
| `just update` | Update all flake inputs |
| `just update-input INPUT` | Update specific input |
| `just diff` | Show configuration diff |
| `just clean` | Clean old generations (30+ days) |
| `just generations` | List all system generations |
| `just search PACKAGE` | Search for packages |
| `just quick MESSAGE` | Commit and switch combined |

## Code Style

- **Indentation:** 2 spaces (never tabs for `.nix` files)
- **Line length:** 100 characters max
- **Formatter:** `nixfmt-rfc-style` (RFC 166)
- **Line endings:** LF, final newline required, trim trailing whitespace

### Module Structure

Follow `modules/TEMPLATE.nix` for new modules:

```nix
##########################################################################
#
#  Module Name - Brief description
#
#  Purpose: What this module does
#  Features:
#    - Feature 1
#    - Feature 2
#  Notes: Any important notes
#
##########################################################################
{ config, pkgs, lib, ... }:
{
  # ========================================================================
  # Section Name
  # ========================================================================

  option.name = value;
}
```

### Import Patterns

```nix
{ config, pkgs, lib, ... }:  # Full - when all are needed
{ pkgs, ... }:               # Minimal - only what's used
_:                           # None - when no parameters needed
```

### Package Lists

```nix
environment.systemPackages = with pkgs; [
  package1  # Description
  package2  # Description
];
```

## Key Conventions

- **Optional modules:** Commented out in `modules/default.nix` (uncomment to enable)
- **Conditional config:** Use `lib.mkIf`, `lib.mkEnableOption`, `lib.mkForce`
- **Hardware file:** Never edit `hardware-configuration.nix`
- **Pinned packages:** Use `nixpkgs-opencode` input for broken packages in unstable

## Notable Features

### Desktop
- KDE Plasma 6 with SDDM display manager
- Catppuccin Mocha theme (system-wide via catppuccin input)
- plasma-manager for declarative Plasma configuration
- Multi-monitor wallpaper support using `pkgs.fetchurl`

### Audio Production
- Bitwig Studio 6 DAW
- Windows VST support via yabridge (auto-sync on activation)
- Plugin definitions in `modules/audio/plugins/` (auto-discovered)
- Realtime audio priorities configured via PAM

### Development
- VSCodium with extensions (`modules/home/vscode.nix`)
- LazyVim Neovim configuration (`modules/home/lazyvim.nix`)
- Nushell as default shell with Starship prompt
- Kitty terminal emulator
- Modern CLI tools: ripgrep, fd, dust, bat, yazi, eza

### Hardware
- AMD GPU with AMDGPU driver and LACT for monitoring
- ROCm support for AI/ML workloads
- PipeWire audio with low-latency configuration
- Secure Boot via Lanzaboote with sbctl

### Networking
- Tailscale VPN
- Firewall enabled by default
- NetworkManager

## User Configuration

- **Username:** `vee`
- **Shell:** Nushell
- **Groups:** networkmanager, input, wheel, video, realtime, audio, tss, plugdev
- **Home directory:** `/home/vee`
- **Git identity:** Version33 / vee@versionthirtythr.ee

## Common Tasks

### Adding a New Module

1. Copy `modules/TEMPLATE.nix` to appropriate category directory
2. Implement the module following the template structure
3. Add import to `modules/default.nix` (or comment out if optional)
4. Run `just fmt && just check` to validate
5. Run `just switch` to apply

### Adding a Windows VST Plugin

1. Create a `.nix` file in `modules/audio/plugins/`
2. Follow existing plugin patterns (see other files in directory)
3. Plugin is auto-discovered by `windows-vst.nix`
4. Run `just switch` - yabridge syncs automatically

### Enabling Optional Features

Uncomment the relevant import in `modules/default.nix`:
- GNOME desktop: `./desktop/gnome.nix`
- VPN: `./network/vpn.nix`
- Virtualisation: `./development/virtualisation.nix`
- Rust development: `./development/rust.nix`
- Printing: `./services/printing.nix`

## Debugging

- Check build errors: `just build 2>&1 | less`
- Test without applying: `just test`
- View diff before switch: `just diff`
- Rollback: `sudo nixos-rebuild switch --rollback`
- Boot previous generation: Select from bootloader menu
