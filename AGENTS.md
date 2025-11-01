# NixOS Configuration - Agent Guidelines

## Project Overview
- **Type:** NixOS system configuration using flakes and flake-parts
- **Structure:** Modular design with organized categories (boot, hardware, desktop, development, audio, services, home-manager)
- **Main files:** `flake.nix`, `configuration.nix`, `modules/default.nix` (module imports), `hardware-configuration.nix` (auto-generated, do not edit)
- **Features:** KDE Plasma 6, secure boot (lanzaboote), AMD GPU support, audio production (yabridge, VST plugins), development tools
- **Flake inputs:** nixpkgs (unstable), home-manager, plasma-manager, catppuccin, audio.nix, lanzaboote
- **Module organization:** See `modules/default.nix` for all active/optional modules; create new modules using `modules/TEMPLATE.nix`

## Build Commands
- **Build:** `just build` or `nom build '.#nixosConfigurations.k0or.config.system.build.toplevel'`
- **Switch:** `just switch` (builds then applies)
- **Test VM:** `just vm`
- **Lint:** `statix check .`
- **Format:** `just fmt` (uses `nixfmt-rfc-style`)
- **Check flake:** `just flake-check` or `nom flake check`

## Code Style
- **Indentation:** 2 spaces (never tabs for `.nix` files)
- **Line length:** 100 characters max (see `.editorconfig`)
- **Formatter:** `nixfmt-rfc-style` (RFC 166)
- **Module structure:** Follow `modules/TEMPLATE.nix` - includes header comment block with purpose/features, standard attribute order (imports, options, config), section separators with comments
- **Imports:** Standard pattern is `{ config, pkgs, lib, ... }:` or `{ pkgs, ... }:` (only include needed parameters)
- **Comments:** Use header comments for modules; inline comments for complex logic only
- **Hardware file:** Never edit `hardware-configuration.nix`
- **System packages:** Use `with pkgs;` for package lists
- **Line endings:** LF, final newline required, trim trailing whitespace

## Conventions
- Host name: `k0or`
- State version: `25.05` (never change)
- Primary user: `vee`
- Use `lib.mkIf`, `lib.mkEnableOption` for conditional config
- Reference existing modules before creating new patterns
