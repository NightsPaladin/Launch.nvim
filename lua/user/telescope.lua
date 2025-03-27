local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }
}

function M.config()
  local wk = require "which-key"
  wk.add {
    { "<leader>fb", "<cmd>Telescope buffers previewer=false<cr>", desc = "Buffers" },
    { "<leader>fc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
    { "<leader>fp", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = "Projects" },
    { "<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "Text" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Last Search" },
    { "<leader>fo", "<cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<cr>", desc = "Search Open Files" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>fs", "<cmd>Telescope symbols<cr>", desc = "Symbols" },
  }

  wk.add {
    { "<leader>ss", "<cmd>Telescope colorscheme<CR>", desc = "Color Scheme" },
  }

  local icons = require "user.icons"
  local actions = require "telescope.actions"
  local actions_state = require "telescope.actions.state"
  local transform_mod = require "telescope.actions.mt".transform_mod

  -- Taken from https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1220846367
  --
  local function multiopen(prompt_bufnr, method)
    local edit_file_cmd_map = {
      vertical = "vsplit",
      horizontal = "split",
      default = "edit",
    }
    local edit_buf_cmd_map = {
      vertical = "vert sbuffer",
      horizontal = "sbuffer",
      default = "buffer",
    }
    local picker = actions_state.get_current_picker(prompt_bufnr)
    local multi_selection = picker:get_multi_selection()

    if #multi_selection > 1 then
      require("telescope.pickers").on_close_prompt(prompt_bufnr)
      pcall(vim.api.nvim_set_current_win, picker.original_win_id)

      for i, entry in ipairs(multi_selection) do
        local filename, row, col

        if entry.path or entry.filename then
          filename = entry.path or entry.filename

          row = entry.row or entry.lnum
          col = vim.F.if_nil(entry.col, 1)
        elseif not entry.bufnr then
          local value = entry.value
          if not value then
            return
          end

          if type(value) == "table" then
            value = entry.display
          end

          local sections = vim.split(value, ":")

          filename = sections[1]
          row = tonumber(sections[2])
          col = tonumber(sections[3])
        end

        local entry_bufnr = entry.bufnr

        if entry_bufnr then
          if not vim.api.nvim_get_option_value("buflisted", { buf = entry_bufnr }) then
            vim.api.nvim_set_option_value("buflisted", true, { buf = entry_bufnr })
          end
          local command = i == 1 and "buffer" or edit_buf_cmd_map[method]
          pcall(vim.cmd, string.format("%s %s", command, vim.api.nvim_buf_get_name(entry_bufnr)))
        else
          local command = i == 1 and "edit" or edit_file_cmd_map[method]
          if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
            filename = require("plenary.path"):new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
            pcall(vim.cmd, string.format("%s %s", command, filename))
          end
        end

        if row and col then
          pcall(vim.api.nvim_win_set_cursor, 0, { row, col - 1 })
        end
      end
    else
      actions["select_" .. method](prompt_bufnr)
    end
  end

  local custom_actions = transform_mod({
    multi_selection_open_vertical = function(prompt_bufnr)
      multiopen(prompt_bufnr, "vertical")
    end,
    multi_selection_open_horizontal = function(prompt_bufnr)
      multiopen(prompt_bufnr, "horizontal")
    end,
    multi_selection_open = function(prompt_bufnr)
      multiopen(prompt_bufnr, "default")
    end,
  })
  
  local function stopinsert(callback)
    return function(prompt_bufnr)
      vim.cmd.stopinsert()
      vim.schedule(function()
        callback(prompt_bufnr)
      end)
    end
  end

  local multi_open_mappings = {
    i = {
      ["<C-v>"] = stopinsert(custom_actions.multi_selection_open_vertical),
      ["<C-s>"] = stopinsert(custom_actions.multi_selection_open_horizontal),
      ["<CR>"] = stopinsert(custom_actions.multi_selection_open),
    },
    n = {
      ["<C-v>"] = custom_actions.multi_selection_open_vertical,
      ["<C-s>"] = custom_actions.multi_selection_open_horizontal,
      ["<CR>"] = custom_actions.multi_selection_open,
    },
  }

  local ts_select_dir_for_grep = function(prompt_bufnr)
    local action_state = require("telescope.actions.state")
    local fb = require("telescope").extensions.file_browser
    local live_grep = require("telescope.builtin").live_grep
    local current_line = action_state.get_current_line()

    fb.file_browser({
      files = false,
      depth = false,
      attach_mappings = function(prompt_bufnr)
        require("telescope.actions").select_default:replace(function()
          local entry_path = action_state.get_selected_entry().Path
          local dir = entry_path:is_dir() and entry_path or entry_path:parent()
          local relative = dir:make_relative(vim.fn.getcwd())
          local absolute = dir:absolute()

          live_grep({
            results_title = relative .. "/",
            cwd = absolute,
            default_text = current_line,
          })
        end)

        return true
      end,
    })
  end

  require("telescope").setup {
    defaults = {
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = icons.ui.Forward .. " ",
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      path_display = { "truncate" },
      sorting_strategy = "ascending",
      color_devicons = true,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },

      layout_strategy = "vertical",
      layout_config = {
        center = {
          width = 0.8,
          height = 0.8,
          preview_width = 120,
          prompt_position = "top",
        },
        horizontal = {
          width = 0.8,
          height = 0.8,
          preview_width = 120,
          prompt_position = "top",
        },
        vertical = {
          width = 0.8,
          height = 0.8,
          preview_width = 120,
          prompt_position = "top",
        },
      },

      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-c>"] = actions.close,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,

          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<C-b>"] = actions.results_scrolling_up,
          ["<C-f>"] = actions.results_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<C-S-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        },
        n = {
          ["<esc>"] = actions.close,

          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<C-S-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
				  ["<C-d>"] = actions.preview_scrolling_down,

          ["<C-b>"] = actions.results_scrolling_up,
          ["<C-f>"] = actions.results_scrolling_down,

          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["q"] = actions.close,
        },
      },
    },
    pickers = {
      live_grep = {
        -- theme = "dropdown",
        mappings = vim.tbl_deep_extend("force", multi_open_mappings,
          {
            i = {
              ["<C-f>"] = ts_select_dir_for_grep,
            },
            n = {
              ["<C-f>"] = ts_select_dir_for_grep,
            },
          }),
      },

      grep_string = {
        -- theme = "dropdown",
        mappings = multi_open_mappings,
      },

      find_files = {
        -- theme = "dropdown",
        mappings = multi_open_mappings,
        -- previewer = false,
        find_command = {
          "fd",
          ".",
          "--type",
          "file",
          "--hidden",
          "--strip-cwd-prefix",
        }
      },

      buffers = {
        -- theme = "dropdown",
        previewer = false,
        mappings = vim.tbl_deep_extend("force", multi_open_mappings,
          {
            i = {
              ["<C-S-d>"] = actions.delete_buffer,
            },
            n = {
              ["dd"] = actions.delete_buffer,
            },
          }),
      },

      git_status = {
        previewer = false,
        mappings = multi_open_mappings,
      },

      planets = {
        show_pluto = true,
        show_moon = true,
      },

      colorscheme = {
        enable_preview = true,
      },

      lsp_references = {
        -- theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_definitions = {
        -- theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_declarations = {
        -- theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_implementations = {
        -- theme = "dropdown",
        initial_mode = "normal",
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
      file_browser = {
        theme = "ivy",
        hijack_netrw = true,
      }
    },
  }
end

return M
