local M = {
  "folke/which-key.nvim",
  opts = {
    preset = "helix",
  },
}

function M.config()
  local mappings = {
    { "<leader>w", "<cmd>w!<CR>", desc = "Save" },
    { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
    { "<leader>h", "<cmd>nohlsearch<CR>", desc = "Remove Search Highlight" },
    { "<leader>0", group = "Toggle Line Numbers" },
    { "<leader>0r", "<cmd>set invrelativenumber<CR>", desc = "Toggle Relative Line Numbers" },
    { "<leader>0n", "<cmd>set invnumber<CR>", desc = "Toggle Line Numbers" },
    -- { "<leader>;", "<cmd>tabnew | terminal<CR>", desc = "Term" }, -- Removed as I don't want tabbed terminals
    { "<leader>v", "<cmd>vsplit<CR>", desc = "Split" },
    { "<leader>b", group = "Buffers" },
    { "<leader>d", group = "Debug" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>l", group = "LSP" },
    { "<leader>p", group = "Plugins" },
    { "<leader>s", group = "Settings" },
    { "<leader>sc", ":e ~/.config/nvim/init.lua<cr>", desc="Config"},
    { "<leader>t", group = "Test" },
    { "<leader>T", group = "Treesitter" },
    -- Removed as I don't use tabs
    -- a = {
    --   name = "Tab",
    --   n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
    --   N = { "<cmd>tabnew %<cr>", "New Tab" },
    --   o = { "<cmd>tabonly<cr>", "Only" },
    --   h = { "<cmd>-tabmove<cr>", "Move Left" },
    --   l = { "<cmd>+tabmove<cr>", "Move Right" },
    -- },
  }

  local which_key = require "which-key"
  which_key.setup {
    -- plugins = {
    --   marks = true,
    --   registers = true,
    --   spelling = {
    --     enabled = true,
    --     suggestions = 20,
    --   },
    --   presets = {
    --     operators = false,
    --     motions = false,
    --     text_objects = false,
    --     windows = false,
    --     nav = false,
    --     z = false,
    --     g = false,
    --   },
    -- },
    win = {
      border = "rounded",
    --   position = "bottom",
      padding = { 2, 2, 2, 2 },
    },
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  which_key.add(mappings)
end

return M
