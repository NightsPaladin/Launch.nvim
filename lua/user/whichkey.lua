local M = {
  "folke/which-key.nvim",
}

function M.config()
  local mappings = {
    w = { "<cmd>w!<CR>", "Save" },
    q = { "<cmd>confirm q<CR>", "Quit" },
    h = { "<cmd>nohlsearch<CR>", "NOHL" },
    ["0"] = { "<cmd>set invnumber<CR>", "Toggle Line Numbers" },
    -- [";"] = { "<cmd>tabnew | terminal<CR>", "Term" }, -- Removed as I don't want tabbed terminals
    v = { "<cmd>vsplit<CR>", "Split" },
    b = { name = "Buffers" },
    d = { name = "Debug" },
    f = { name = "Find" },
    g = { name = "Git" },
    l = { name = "LSP" },
    p = { name = "Plugins" },
    s = { name = "Settings" },
    t = { name = "Test" },
    -- a = {
    --   name = "Tab",
    --   n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
    --   N = { "<cmd>tabnew %<cr>", "New Tab" },
    --   o = { "<cmd>tabonly<cr>", "Only" },
    --   h = { "<cmd>-tabmove<cr>", "Move Left" },
    --   l = { "<cmd>+tabmove<cr>", "Move Right" },
    -- },
    T = { name = "Treesitter" },
  }

  local which_key = require "which-key"
  which_key.setup {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    window = {
      border = "rounded",
      position = "bottom",
      padding = { 2, 2, 2, 2 },
    },
    ignore_missing = true,
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
  }

  which_key.register(mappings, opts)
end

return M
