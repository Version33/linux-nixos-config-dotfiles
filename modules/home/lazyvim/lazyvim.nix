{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    extraPackages = with pkgs; [
      # LazyVim requirements
      git
      lazygit
      stylua
      lua-language-server
      ripgrep
      fd
      fzf
      
      # Build dependencies
      gcc
      gnumake
      unzip
      wget
      curl
      tree-sitter
      
      # Common LSPs/Formatters (optional but good to have)
      nixd
      nixfmt-rfc-style
      markdown-oxide
    ];
  };

  # Link the Neovim configuration
  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
