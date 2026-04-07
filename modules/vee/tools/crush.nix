{
  # Charm's agentic coding tool - available via NUR (Nix User Repository)
  flake-file.inputs.nur.url = "github:nix-community/NUR";

  flake.modules.nixos.crush =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.nur.repos.charmbracelet.crush
      ];
    };
}
