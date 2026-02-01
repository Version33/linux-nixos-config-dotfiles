{ ... }:
{

  flake.modules.homeManager.lsp-plugins =
    { pkgs, ... }:
    {
      home.file.".vst/lsp-plugins".source = "${pkgs.lsp-plugins}/lib/vst";
      home.file.".vst3/lsp-plugins".source = "${pkgs.lsp-plugins}/lib/vst3";
    };

}
