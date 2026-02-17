{
  flake.modules.nixos.lsp-plugins-vst =
    { pkgs, ... }:
    {
      # Create VST plugin symlinks for audio production
      system.activationScripts.lsp-plugins-vst = ''
        mkdir -p /home/vee/.vst /home/vee/.vst3
        ln -sf ${pkgs.lsp-plugins}/lib/vst /home/vee/.vst/lsp-plugins
        ln -sf ${pkgs.lsp-plugins}/lib/vst3 /home/vee/.vst3/lsp-plugins
      '';
    };
}
