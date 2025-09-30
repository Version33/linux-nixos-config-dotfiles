{ pkgs, ... }:

{
  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    # 0xProto
    nerd-font-patcher
    noto-fonts-color-emoji
  ];
}
