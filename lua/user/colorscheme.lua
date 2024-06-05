local M = {
  -- "LunarVim/darkplus.nvim",
  -- "sjl/badwolf",
  "RRethy/nvim-base16",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  -- vim.cmd.colorscheme "darkplus"
  vim.cmd.colorscheme "base16-gruvbox-dark-pale"
end

return M
