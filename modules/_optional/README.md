# Optional Modules

This directory contains **optional** NixOS configuration modules that are **not automatically loaded** by import-tree.

Files in directories starting with `_` (underscore) are ignored by import-tree's automatic discovery.

## Available Optional Modules

| Module | Description | To Enable |
|--------|-------------|-----------|
| `gnome.nix` | GNOME desktop environment | Add to flake.nix imports (conflicts with KDE) |
| `theme.nix` | Additional theming options | Add to flake.nix imports |
| `windows-vst.nix` | Windows VST plugin support via yabridge | Add to flake.nix imports |
| `local-services.nix` | Local network services | Add to flake.nix imports |
| `open-ssh.nix` | OpenSSH server | Add to flake.nix imports |
| `vpn.nix` | VPN configuration | Add to flake.nix imports |
| `auto-upgrade.nix` | Automatic system updates (weekly) | Add to flake.nix imports |
| `clamav-scanner.nix` | ClamAV virus scanner (Saturdays 4am) | Add to flake.nix imports |
| `location.nix` | Geoclue2 location services | Add to flake.nix imports |
| `printing.nix` | CUPS printing support | Add to flake.nix imports |
| `security-services.nix` | Comprehensive security hardening (AppArmor, Firejail, fail2ban, etc.) | Add to flake.nix imports |

## How to Enable an Optional Module

Add the module to the `imports` list in `flake.nix`:

```nix
imports = [
  inputs.flake-parts.flakeModules.modules
  ./flake-modules/nixos-systems.nix
  ./flake-modules/dev-shell.nix
  ./modules/_optional/printing.nix  # Enable CUPS printing
] ++ dendriticImports.imports;
```

**Note:** Some modules may conflict with each other (e.g., GNOME and KDE both try to set the display manager).

## Why These Are Optional

These modules are kept optional because they:

1. **Conflict with active modules** (e.g., GNOME conflicts with KDE)
2. **Require specific hardware/setup** (e.g., printing requires a printer)
3. **Add significant overhead** (e.g., security-services adds many AppArmor profiles)
4. **Are use-case specific** (e.g., windows-vst is only for audio production)
5. **Modify system behavior** (e.g., auto-upgrade automatically updates the system)

## Directory Structure

```
modules/_optional/
├── README.md                    # This file
├── gnome.nix                    # GNOME desktop (conflicts with KDE)
├── theme.nix                    # Additional theming
├── windows-vst.nix              # Windows VST support
├── local-services.nix           # Local network services
├── open-ssh.nix                 # SSH server
├── vpn.nix                      # VPN configuration
├── auto-upgrade.nix             # Automatic updates
├── clamav-scanner.nix           # Virus scanner
├── location.nix                 # Location services
├── printing.nix                 # Printing support
└── security-services.nix        # Security hardening
```
