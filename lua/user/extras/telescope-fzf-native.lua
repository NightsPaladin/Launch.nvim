local M = {
  "nvim-telescope/telescope-fzf-native.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  build = "make"
}

function M.config()
  require("telescope").load_extension "fzf"
end

return M
