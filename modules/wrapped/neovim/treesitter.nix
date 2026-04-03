{
  neovimModules = [
    (
      { pkgs, ... }:
      let
        grammars = pkgs.vimPlugins.nvim-treesitter.grammarPlugins;
      in
      {
        config.vim.treesitter = {
          enable = true;
          fold = true;
          # Explicit grammars on top of nvf defaults (c lua vim vimdoc query)
          grammars = with grammars; [
            bash
            css
            diff
            html
            javascript
            jsdoc
            json
            luadoc
            luap
            markdown
            markdown_inline
            nix
            python
            regex
            rust
            toml
            tsx
            typescript
            xml
            yaml
          ];
        };
      }
    )
  ];
}
