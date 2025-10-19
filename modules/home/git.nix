{ pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      userName = "Version33";
      userEmail = "vee@versionthirtythr.ee";
      extraConfig = {
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
      };
      aliases = {
        pu = "push";
        co = "checkout";
        cm = "commit";
      };
      delta.enable = true; # Syntax-highlighting pager for git
    };
    gh.enable = true; # GitHub CLI tool
    bat.enable = true; # Cat(-1) clone with syntax highlighting and Git integration.
    lazygit.enable = true; # Simple terminal UI for git commands
  };
  home.packages = with pkgs; [
    git-ignore # Quickly and easily fetch .gitignore templates from gitignore.io
    gitleaks # Scan git repos (or files) for secrets
    git-secrets # Prevents you from committing secrets and credentials into git repositories
    # pass-git-helper # Git credential helper interfacing with pass, the standard unix password manager.
  ];
}
