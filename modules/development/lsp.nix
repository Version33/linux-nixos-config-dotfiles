{

  flake.modules.nixos.lsp =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        markdown-oxide
        nixd # nil
      ];
    };

}
