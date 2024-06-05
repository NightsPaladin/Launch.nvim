local M = {
  "nvim-lualine/lualine.nvim",
}

function M.config()
  local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end

  local mode = {
    "mode",
    fmt = function(str) return str:sub(1,3) end
  }

  local diff = {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width
  }

  local filename = {
    "filename",
    file_status = true, -- displays file status (readonly, modified, etc.)
    path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
  }
  
  local filetype = {
    "filetype",
    icons_enabled = false,
    icon = nil,
    color = { fg = "User1"},
  }
  
  local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
  }

  local location = {
    "location",
    padding = 0,
  }

  local spaces = function()
    return "spaces: " .. vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
  end

  require("lualine").setup {
    options = {
      theme = "base16",
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
      always_divide_middle = true,
      ignore_focus = { "NvimTree" },
    },
    sections = {
      lualine_a = { mode },
      lualine_b = { branch, "diagnostics" },
      lualine_c = { filename },
      lualine_x = { diff, spaces, "encoding", filetype },
      lualine_y = { location },
      lualine_z = { "progress" },
    },
    extensions = { "quickfix", "man", "fugitive" },
  }
end

return M
