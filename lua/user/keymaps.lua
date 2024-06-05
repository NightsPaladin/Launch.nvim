local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap("n", "<C-i>", "<C-i>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-tab>", "<C-6>", opts)

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("x", "p", [["_dP]])

vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- more good
keymap({ "n", "o", "x" }, "<C-S-h>", "^", opts)
keymap({ "n", "o", "x" }, "<C-S-l>", "g_", opts)

-- tailwind bearable to work with
keymap({ "n", "x" }, "j", "gj", opts)
keymap({ "n", "x" }, "k", "gk", opts)
keymap("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", opts)

-- Resize with arrows
keymap("n", "<Leader><Up>", ":resize +5<CR>", opts)
keymap("n", "<Leader><Down>", ":resize -5<CR>", opts)
keymap("n", "<Leader><Left>", ":vertical resize -5<CR>", opts)
keymap("n", "<Leader><Right>", ":vertical resize +5<CR>", opts)

-- Move text up and down
keymap("n", "<C-J>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<C-K>", "<Esc>:m .-2<CR>==gi", opts)

-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
-- keymap("i", "kj", "<ESC>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>bdelete<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

vim.api.nvim_set_keymap('t', '<C-;>', '<C-\\><C-n>', opts)
