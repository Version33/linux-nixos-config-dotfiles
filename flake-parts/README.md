# Flake Parts

This directory contains modular flake configuration using [flake-parts](https://flake.parts/).

## Why flake-parts?

flake-parts provides better organization by:
- Splitting the monolithic flake into focused modules
- Providing `perSystem` for system-specific configuration
- Making it easier to add new systems (laptop, server, etc.)
- Enabling reusable configuration pieces

## Structure

- **nixos-systems.nix** - NixOS system configurations (k0or)
- **dev-shell.nix** - Development shell with tools for working on this config

## Adding a New System

To add a new machine configuration:

1. Create its hardware-configuration.nix
2. Edit `nixos-systems.nix`:
   ```nix
   flake.nixosConfigurations = {
     k0or = { ... };  # existing

     laptop = inputs.nixpkgs.lib.nixosSystem {
       specialArgs = { inherit inputs; };
       modules = [
         ../laptop-configuration.nix
         ../laptop-hardware.nix
         ../modules
       ];
     };
   };
   ```

## Adding New Flake Outputs

Create a new file in this directory, e.g., `packages.nix`:

```nix
{ inputs, ... }:

{
  perSystem = { pkgs, ... }: {
    packages.my-tool = pkgs.callPackage ./packages/my-tool.nix { };
  };
}
```

Then import it in `flake.nix`:
```nix
imports = [
  ./flake-parts/nixos-systems.nix
  ./flake-parts/dev-shell.nix
  ./flake-parts/packages.nix  # new
];
```

## perSystem vs flake

- **perSystem**: Applies to each system in the `systems` list (e.g., `x86_64-linux`)
  - Use for: devShells, packages, apps, checks
  - Automatically provides `pkgs` for the current system

- **flake**: Top-level flake outputs
  - Use for: nixosConfigurations, nixosModules, overlays
  - System-agnostic outputs

## Resources

- [flake-parts Documentation](https://flake.parts/)
- [Examples](https://github.com/hercules-ci/flake-parts/tree/main/examples)
