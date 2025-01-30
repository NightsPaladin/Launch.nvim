local M = {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
}

function M.config()
  require("telescope").load_extension "file_browser"
end

return M
