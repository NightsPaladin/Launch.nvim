vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
    vim.cmd "set formatoptions+=j"
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "",
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd "quit"
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd "checktime"
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 40 }
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

local opts = { noremap = true, silent = true }
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "telekasten" },
	callback = function()
		vim.api.nvim_set_keymap("i", "[[", "<cmd>Telekasten insert_link<CR>", opts)
		vim.api.nvim_set_keymap("i", "<Leader>zt", "<cmd>Telekasten toggle_todo<CR>", opts)
		vim.api.nvim_set_keymap("i", "<Leader>#", "<cmd>Telekasten show_tags<CR>", opts)
		vim.cmd([[
        "hi tkLink ctermfg=Blue cterm=bold,underline guifg=blue gui=bold,underline   " just blue and gray links
        "hi tkBrackets ctermfg=gray guifg=gray
        hi tkLink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline    " for gruvbox
        hi tkBrackets ctermfg=gray guifg=gray
        "hi tkHighlight ctermbg=yellow ctermfg=darkred cterm=bold guibg=yellow guifg=darkred gui=bold    " real yellow
        hi tkHighlight ctermbg=214 ctermfg=124 cterm=bold guibg=#fabd2f guifg=#9d0006 gui=bold   " gruvbox
        hi link CalNavi CalRuler
        hi tkTagSep ctermfg=gray guifg=gray
        hi tkTag ctermfg=175 guifg=#d3869B
        ]])
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "python" },
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "help" },
	callback = function()
		vim.api.nvim_set_keymap("n", "<CR>", "<C-]>", opts)
		vim.api.nvim_set_keymap("n", "<BS>", "<C-T>", opts)
		vim.api.nvim_set_keymap("n", "o", "/'\\l\\{2,\\}'<CR>", opts)
		vim.api.nvim_set_keymap("n", "O", "?'\\l\\{2,\\}'<CR>", opts)
		vim.api.nvim_set_keymap("n", "s", "/\\|\\zs\\S\\+\\ze\\|<CR>", opts)
		vim.api.nvim_set_keymap("n", "S", "?\\|\\zs\\S\\+\\ze\\|<CR>", opts)
		vim.cmd([[ setlocal bufhidden=unload | wincmd L | vertical resize 80 ]])
	end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    local status_ok, luasnip = pcall(require, "luasnip")
    if not status_ok then
      return
    end
    if luasnip.expand_or_jumpable() then
      -- ask maintainer for option to make this silent
      -- luasnip.unlink_current()
      vim.cmd [[silent! lua require("luasnip").unlink_current()]]
    end
  end,
})
