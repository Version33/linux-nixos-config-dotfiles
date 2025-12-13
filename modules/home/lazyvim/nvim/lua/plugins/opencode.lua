return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    -- LazyVim-style keymaps matching claudecode.lua bindings
    vim.keymap.set({ "n", "v" }, "<leader>a", "", { desc = "+ai" })

    -- Main actions (matching claudecode)
    vim.keymap.set({ "n", "v" }, "<leader>ac", function()
      require("opencode").toggle()
    end, { desc = "Toggle OpenCode" })

    vim.keymap.set("n", "<leader>af", function()
      require("opencode").toggle()
    end, { desc = "Focus OpenCode" })

    vim.keymap.set({ "n", "v" }, "<leader>ab", function()
      require("opencode").prompt("@this")
    end, { desc = "Add current buffer" })

    vim.keymap.set("v", "<leader>as", function()
      require("opencode").prompt("@this")
    end, { desc = "Send to OpenCode" })

    -- Ask/action menu
    vim.keymap.set({ "n", "v" }, "<leader>aa", function()
      require("opencode").select()
    end, { desc = "OpenCode actions" })

    -- Session management
    vim.keymap.set("n", "<leader>ar", function()
      require("opencode").command("session.new")
    end, { desc = "Resume/New session" })

    vim.keymap.set("n", "<leader>al", function()
      require("opencode").command("session.list")
    end, { desc = "List sessions" })

    -- Additional useful bindings
    vim.keymap.set({ "n", "v" }, "<leader>ai", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask OpenCode" })
  end,
}
