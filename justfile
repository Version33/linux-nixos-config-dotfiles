# NixOS Configuration Management

# Default recipe to display help
default:
    @just --list

# Build and switch to the new configuration (with nom for better output)
switch:
    sudo nom build '.#nixosConfigurations.k0or.config.system.build.toplevel' && sudo nixos-rebuild switch --flake .#k0or

# Build and switch (plain output, fallback option)
switch-plain:
    sudo nixos-rebuild switch --flake .#k0or

# Build without switching (with nom for better output)
build:
    nom build '.#nixosConfigurations.k0or.config.system.build.toplevel'

# Build (plain output, fallback option)
build-plain:
    nixos-rebuild build --flake .#k0or

# Build and test in a VM
vm:
    nixos-rebuild build-vm --flake .#k0or
    ./result/bin/run-k0or-vm

# Update flake inputs
update:
    nix flake update

# Update specific input (e.g., just update-input nixpkgs)
update-input INPUT:
    nix flake lock --update-input {{INPUT}}

# Format all nix files
fmt:
    nixpkgs-fmt .

# Check for issues with statix
check:
    statix check .

# Find and remove unused code
deadcode:
    deadnix .

# Check flake and show any errors (with nom for better output)
flake-check:
    nom flake check

# Check flake (plain output, fallback option)
flake-check-plain:
    nix flake check

# Show flake metadata
flake-info:
    nix flake metadata

# Show what would be built/downloaded
dry-run:
    nixos-rebuild dry-build --flake .#k0or

# Clean up old generations (keeps last 5)
clean:
    sudo nix-collect-garbage --delete-older-than 30d
    sudo nixos-rebuild switch --flake .#k0or

# List all generations
generations:
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Show disk usage of nix store
disk-usage:
    du -sh /nix/store

# Optimize nix store
optimize:
    sudo nix-store --optimize

# Show system configuration diff
diff:
    nixos-rebuild build --flake .#k0or
    nix store diff-closures /run/current-system ./result

# Git commit with conventional message
commit MESSAGE:
    git add .
    git commit -m "{{MESSAGE}}"

# Quick commit and switch
quick MESSAGE: (commit MESSAGE) switch

# Show dependency tree (requires nix-tree)
tree:
    nix-tree /run/current-system

# Search for a package
search PACKAGE:
    nix search nixpkgs {{PACKAGE}}

# Enter development shell
dev:
    nix develop

# Setup direnv hooks for automatic environment loading
setup-direnv:
    @echo "Setting up direnv hooks..."
    @if ! grep -q 'eval "$(direnv hook' ~/.bashrc ~/.zshrc ~/.config/fish/config.fish 2>/dev/null; then \
        echo "Add one of these to your shell config:"; \
        echo "  Bash: echo 'eval \"\$(direnv hook bash)\"' >> ~/.bashrc"; \
        echo "  Zsh:  echo 'eval \"\$(direnv hook zsh)\"' >> ~/.zshrc"; \
        echo "  Fish: echo 'direnv hook fish | source' >> ~/.config/fish/config.fish"; \
        echo "  Nushell: see https://direnv.net/docs/hook.html#nushell"; \
    else \
        echo "direnv hooks already configured!"; \
    fi
    @echo ""
    @echo "After setting up hooks, run: direnv allow"
