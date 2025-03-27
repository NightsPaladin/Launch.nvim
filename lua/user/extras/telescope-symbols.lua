local M = {
    "nvim-telescope/telescope-symbols.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
}

function M.config()
  -- require("telescope").load_extension "symbols"
end

return M
