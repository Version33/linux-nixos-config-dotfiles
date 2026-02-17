{
  flake.modules.nixos.git-tools =
    { pkgs, ... }:
    {
      # Git ecosystem tools
      environment.systemPackages = with pkgs; [
        lazygit
        delta
        gh
        bat
        git-ignore
        gitleaks
        git-secrets
      ];
    };
}
