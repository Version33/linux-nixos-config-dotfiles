{
  neovimModules = [
    {
      config.vim.git = {
        enable = true;
        gitsigns = {
          enable = true;
          # LazyVim sign glyphs
          setupOpts = {
            signs = {
              add = {
                text = "▎";
              };
              change = {
                text = "▎";
              };
              delete = {
                text = "";
              };
              topdelete = {
                text = "";
              };
              changedelete = {
                text = "▎";
              };
              untracked = {
                text = "▎";
              };
            };
            signs_staged = {
              add = {
                text = "▎";
              };
              change = {
                text = "▎";
              };
              delete = {
                text = "";
              };
              topdelete = {
                text = "";
              };
              changedelete = {
                text = "▎";
              };
            };
          };
          mappings = {
            nextHunk = "]h";
            previousHunk = "[h";
            stageHunk = "<leader>ghs";
            resetHunk = "<leader>ghr";
            stageBuffer = "<leader>ghS";
            undoStageHunk = "<leader>ghu";
            resetBuffer = "<leader>ghR";
            previewHunk = "<leader>ghp";
            blameLine = "<leader>ghb";
            toggleBlame = "<leader>ghB";
            diffThis = "<leader>ghd";
            diffProject = "<leader>ghD";
            toggleDeleted = "<leader>ghT";
          };
        };
      };
    }
  ];
}
