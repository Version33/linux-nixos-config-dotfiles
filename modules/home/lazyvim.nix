{ inputs, ... }:
{
  # LazyVim Neovim configuration
  flake-file.inputs.lazyvim.url = "github:pfassina/lazyvim-nix";
  # Neovim AI integration (non-flake)
  flake-file.inputs.opencode-nvim = {
    url = "github:NickvanDyke/opencode.nvim";
    flake = false;
  };

  flake.modules.homeManager.lazyvim =
    { pkgs, ... }:
    {
      imports = [
        inputs.lazyvim.homeManagerModules.default
      ];
      programs.lazyvim = {
        enable = false;
        extras = {
          coding.yanky.enable = true;
          editor.fzf.enable = true;
          lang = {
            git.enable = true;
            json.enable = true;
            markdown = {
              enable = true;
              installDependencies = true;
              installRuntimeDependencies = true;
            };
            nix = {
              enable = true;
              installDependencies = true;
              installRuntimeDependencies = true;
            };
            python = {
              enable = true;
              installDependencies = true;
              installRuntimeDependencies = true;
            };
            yaml = {
              enable = true;
              installDependencies = true;
              installRuntimeDependencies = true;
            };
            # Kernel development languages
            clangd = {
              enable = true;
              installDependencies = true;
              installRuntimeDependencies = true;
            };
            rust = {
              enable = true;
              installDependencies = true;
              installRuntimeDependencies = true;
            };
            cmake = {
              enable = true;
              installDependencies = true;
              installRuntimeDependencies = true;
            };
            toml = {
              enable = true;
              installDependencies = true;
              installRuntimeDependencies = true;
            };
          };
          # Useful extras for kernel dev
          dap.core.enable = true; # Debugging support
        };
      };
      home.packages = with pkgs; [
        tree-sitter
        statix
        nixpkgs-fmt
        # Additional kernel dev tools
        bear # Generate compile_commands.json
        cscope # Code navigation (kernel classic)
        ctags # Tag generation
      ];
    };

}
