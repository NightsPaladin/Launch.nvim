local M = {
  "folke/which-key.nvim",
}

function M.config()
  local mappings = {
    { "<leader>w", "<cmd>w!<CR>", desc = "Save" },
    { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
    { "<leader>h", "<cmd>nohlsearch<CR>", desc = "NOHL" },
    { "<leader>0", "<cmd>set invnumber<CR>", desc = "Toggle Line Numbers" },
    -- { "<leader>;", "<cmd>tabnew | terminal<CR>", desc = "Term" }, -- Removed as I don't want tabbed terminals
    { "<leader>v", "<cmd>vsplit<CR>", desc = "Split" },
    { "<leader>b", group = "Buffers" },
    { "<leader>d", group = "Debug" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>l", group = "LSP" },
    { "<leader>p", group = "Plugins" },
    { "<leader>s", group = "Settings" },
    { "<leader>t", group = "Test" },
    -- Removed as I don't use tabs
    -- a = {
    --   name = "Tab",
    --   n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
    --   N = { "<cmd>tabnew %<cr>", "New Tab" },
    --   o = { "<cmd>tabonly<cr>", "Only" },
    --   h = { "<cmd>-tabmove<cr>", "Move Left" },
    --   l = { "<cmd>+tabmove<cr>", "Move Right" },
    -- },
    { "<leader>T", group = "Treesitter" },
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
    win = {
      border = "rounded",
      position = "bottom",
      padding = { 2, 2, 2, 2 },
    },
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

  which_key.add(mappings, opts)
end

return M
