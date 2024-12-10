local M = {
    "ruifm/gitlinker.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}

function M.config()
    local wk = require "which-key"
    wk.add {
        { "<leader>gy", "<cmd>lua require('gitlinker').get_buf_range_url('n', {action_callback = require('gitlinker.actions').open_in_browser})<cr>", desc = "Git URL" },
        { "<leader>gy", "<cmd>lua require('gitlinker').get_buf_range_url('v', {action_callback = require('gitlinker.actions').open_in_browser})<cr>", desc = "Git URL", mode = "v" },
    }

    require("gitlinker").setup {
        mappings = nil
    }
end

return M
