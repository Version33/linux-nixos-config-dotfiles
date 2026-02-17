{
  flake.modules.nixos.lsp =
    { pkgs, ... }:
    {
      # Language servers (LSPs already in environment.nix: nil, nixd)
      environment.systemPackages = with pkgs; [
        markdown-oxide
      ];
    };
}
