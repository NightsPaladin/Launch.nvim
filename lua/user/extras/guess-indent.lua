local M = {
  "NMAC427/guess-indent.nvim",
}

function M.config()
  require("guess-indent").setup {
    auto_cmd = true, -- Set to false to disable automatic execution
    override_editorconfig = false, -- Set to true to override settings set by .editorconfig
    filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
      "netrw",
      "tutor",
      "nvimtree",
    },
    buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
      "help",
      "nofile",
      "terminal",
      "prompt",
    },
    on_tab_options = { -- A table of vim options when tabs are detected
      ["expandtab"] = false,
    },
    on_space_options = { -- A table of vim options when spaces are detected
      ["expandtab"] = true,
      ["tabstop"] = "detected", -- If the option value is 'detected', The value is set to the automatically detected indent size.
      ["softtabstop"] = "detected",
      ["shiftwidth"] = "detected",
    },
  }
end

return M
