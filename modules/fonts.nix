{ pkgs, ... }:

{
  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts._0xproto
    # nerd-font-patcher
    noto-fonts-color-emoji
  ];
}
