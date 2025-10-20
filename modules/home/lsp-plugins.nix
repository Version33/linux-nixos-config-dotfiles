# LSP Plugins symlinks for Bitwig Studio
{ config, pkgs, ... }:

{
  home.file.".vst/lsp-plugins".source = "${pkgs.lsp-plugins}/lib/vst";
  home.file.".vst3/lsp-plugins".source = "${pkgs.lsp-plugins}/lib/vst3";
}
