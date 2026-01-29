##############################################################################
# Module Templates for Dendritic Pattern
#
# This file contains templates for creating NixOS and Home Manager modules
# using the dendritic pattern with flake-parts.
#
# Key Concepts:
#   - No header comment blocks in dendritic modules
#   - Keep inline comments on packages and options
#   - Aspect names are lowercase with hyphens (e.g., "my-aspect")
#   - Use { ... }: for the outer module (unless you need inputs/self)
#   - Structure: { ... }: { flake.modules.<class>.<aspect> = {...}: {...}; }
##############################################################################

# ===========================================================================
# NIXOS MODULE TEMPLATES
# ===========================================================================

# ---------------------------------------------------------------------------
# Template 1: Simple Packages (NixOS)
# ---------------------------------------------------------------------------
# Use when: Just installing system packages
# ---------------------------------------------------------------------------
{ ... }:
{

  flake.modules.nixos.my-aspect =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        package1 # Comment explaining package
        package2 # Another comment
      ];
    };

}

# ---------------------------------------------------------------------------
# Template 2: With Services (NixOS)
# ---------------------------------------------------------------------------
# Use when: Configuring system services
# ---------------------------------------------------------------------------
{ ... }:
{

  flake.modules.nixos.my-aspect =
    { pkgs, config, ... }:
    {
      services.myservice = {
        enable = true;
        # service configuration
      };

      environment.systemPackages = with pkgs; [
        related-package
      ];
    };

}

# ---------------------------------------------------------------------------
# Template 3: With Overlay from Inputs (NixOS)
# ---------------------------------------------------------------------------
# Use when: Need to apply an overlay from flake inputs
# ---------------------------------------------------------------------------
{ inputs, ... }:
{

  flake.modules.nixos.my-aspect =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [ inputs.some-overlay.overlays.default ];

      environment.systemPackages = with pkgs; [
        package-from-overlay
      ];
    };

}

# ---------------------------------------------------------------------------
# Template 4: With Flake Module Import (NixOS)
# ---------------------------------------------------------------------------
# Use when: Importing another flake's NixOS module
# ---------------------------------------------------------------------------
{ inputs, ... }:
{

  flake.modules.nixos.my-aspect =
    _:
    {
      imports = [
        inputs.some-flake.nixosModules.module-name
      ];

      # Configuration using the imported module
      services.something = {
        enable = true;
      };
    };

}

# ---------------------------------------------------------------------------
# Template 5: With Hardware Config (NixOS)
# ---------------------------------------------------------------------------
# Use when: Configuring hardware support
# ---------------------------------------------------------------------------
{ ... }:
{

  flake.modules.nixos.my-aspect =
    { pkgs, ... }:
    {
      hardware.mydevice = {
        enable = true;
        # hardware options
      };

      services.udev.extraRules = ''
        # udev rules
      '';

      users.users.vee.extraGroups = [ "mygroup" ];
    };

}

# ---------------------------------------------------------------------------
# Template 6: With User Groups (NixOS)
# ---------------------------------------------------------------------------
# Use when: Creating user groups and permissions
# ---------------------------------------------------------------------------
{ ... }:
{

  flake.modules.nixos.my-aspect =
    _:
    {
      users.groups.mygroup = { };

      users.users.vee.extraGroups = [ "mygroup" ];
    };

}

# ===========================================================================
# HOME MANAGER MODULE TEMPLATES
# ===========================================================================

# ---------------------------------------------------------------------------
# Template 7: Simple Home Packages
# ---------------------------------------------------------------------------
# Use when: Just installing user packages
# ---------------------------------------------------------------------------
{ ... }:
{

  flake.modules.homeManager.my-aspect =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        package1
        package2
      ];
    };

}

# ---------------------------------------------------------------------------
# Template 8: With Program Config (Home Manager)
# ---------------------------------------------------------------------------
# Use when: Configuring home-manager programs
# ---------------------------------------------------------------------------
{ ... }:
{

  flake.modules.homeManager.my-aspect =
    { pkgs, ... }:
    {
      programs.myprogram = {
        enable = true;
        # program configuration
      };

      home.packages = with pkgs; [
        related-package
      ];
    };

}

# ---------------------------------------------------------------------------
# Template 9: With XDG Config Files (Home Manager)
# ---------------------------------------------------------------------------
# Use when: Managing dotfiles/config files
# ---------------------------------------------------------------------------
{ ... }:
{

  flake.modules.homeManager.my-aspect =
    { config, ... }:
    {
      xdg.configFile."myapp/config.json".text = builtins.toJSON {
        setting1 = "value1";
        setting2 = "value2";
      };

      home.file.".myrc".text = ''
        # Config content
        option = value
      '';
    };

}

# ---------------------------------------------------------------------------
# Template 10: With Home Manager Module Import
# ---------------------------------------------------------------------------
# Use when: Importing another flake's home-manager module
# ---------------------------------------------------------------------------
{ inputs, ... }:
{

  flake.modules.homeManager.my-aspect =
    { pkgs, ... }:
    {
      imports = [
        inputs.some-flake.homeManagerModules.module-name
      ];

      programs.something = {
        enable = true;
        # configuration
      };
    };

}

# ---------------------------------------------------------------------------
# Template 11: With Let Bindings (Home Manager)
# ---------------------------------------------------------------------------
# Use when: Need to define local variables (e.g., fetched files)
# ---------------------------------------------------------------------------
{ ... }:
{

  flake.modules.homeManager.my-aspect =
    { pkgs, ... }:
    let
      myFile = pkgs.fetchurl {
        url = "https://example.com/file";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };
    in
    {
      home.file.".config/myfile".source = myFile;

      programs.myprogram = {
        enable = true;
        extraConfig = ''
          source ${myFile}
        '';
      };
    };

}

# ---------------------------------------------------------------------------
# Template 12: With Activation Script (Home Manager)
# ---------------------------------------------------------------------------
# Use when: Need to run commands during home-manager activation
# ---------------------------------------------------------------------------
{ ... }:
{

  flake.modules.homeManager.my-aspect =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      setupScript = pkgs.writeShellScript "setup" ''
        # Setup commands
        echo "Running setup..."
      '';
    in
    {
      home.activation.mySetup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD ${setupScript}
      '';
    };

}

# ===========================================================================
# USAGE NOTES
# ===========================================================================

# 1. Adding a New Module:
#    - Create a .nix file in appropriate modules/ subdirectory
#    - Choose a template based on your needs
#    - Replace "my-aspect" with a descriptive lowercase-hyphen name
#    - Add the file path to flake.nix imports list
#    - Comment out the old import in modules/default.nix (if converting)
#
# 2. Module Parameters:
#    - Use { ... }: when module doesn't need inputs/self
#    - Use { inputs, ... }: when needing flake inputs
#    - Use { inputs, self, ... }: when needing both (rare)
#
# 3. Inner Module Parameters:
#    - _: when no parameters needed
#    - { pkgs, ... }: for most modules
#    - { pkgs, config, lib, ... }: when need config or lib
#
# 4. Aspect Naming:
#    - Use lowercase with hyphens: "my-aspect"
#    - Be descriptive: "amdgpu", "dev-utils", "gaming-hardware"
#    - Avoid generic names: prefer "lsp" over "language-servers"
#
# 5. Comments:
#    - NO header comment blocks (removed in dendritic pattern)
#    - YES inline comments on packages and configuration
#    - Keep existing inline comments when converting
#
# 6. Loading Dendritic Modules:
#    - NixOS: Loaded via nixos-systems.nix using self.modules.nixos
#    - Home: Loaded via home.nix using home-manager.sharedModules
#
# 7. Testing:
#    - List modules: nix eval --impure --json --expr 'let flake = builtins.getFlake "git+file:///home/vee/nixos"; in builtins.attrNames flake.modules.nixos'
#    - Build: nixos-rebuild build --flake .#k0or
#    - Verify: nix-store -q --requisites result | grep package-name
