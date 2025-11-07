_:

{
  # Nix Configuration
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Performance & Storage Optimization
    auto-optimise-store = true; # Automatically deduplicate identical files in /nix/store
    max-jobs = "auto"; # Use all available CPU cores for builds
    cores = 0; # Use all cores per build job (0 = all available)

    # Network & Download Settings
    http-connections = 50; # Increase from default 25 for faster parallel downloads

    # Better error messages and debugging
    show-trace = true; # Show stack traces on evaluation errors

    # Reduce noise during development
    warn-dirty = false; # Don't warn about dirty git trees

    # Trust wheel group users (includes your user account)
    # This allows using additional substituters and other privileged operations
    trusted-users = [
      "root"
      "@wheel"
    ];
  };
}
