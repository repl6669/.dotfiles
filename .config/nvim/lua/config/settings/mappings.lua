local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap comma as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- YY/XX Copy/Cut into the system clipboard
vim.cmd([[
  noremap YY "+y<CR>
  noremap XX "+x<CR>
]])

-- Quick settings access
-- Edit init.lua in new tab
keymap("n", "<Leader>evc", ":edit /Users/theimer/.config/nvim/init.lua<CR>", opts)

-- Edit plugins
keymap("n", "<Leader>epc", ":edit /Users/theimer/.config/nvim/lua/config/plugins/plugins.lua<CR>", opts)

-- Edit mappings
keymap("n", "<Leader>emc", ":edit /Users/theimer/.config/nvim/lua/config/settings/mappings.lua<CR>", opts)

-- Edit LSP coniig
keymap("n", "<Leader>elc", ":edit /Users/theimer/.config/nvim/lua/config/lsp/init.lua<CR>", opts)

-- Edit colorschemes
keymap("n", "<Leader>ecc", ":edit /Users/theimer/.config/nvim/lua/config/settings/colorscheme.lua<CR>", opts)

-- Add simple highlight removal
keymap("n", "<Leader><Space>", ":nohlsearch<CR>", opts)

-- Source init.lua
keymap("n", "<leader>snv", ":source $MYVIMRC<CR>", opts)

-- Disable arrow keys
keymap("n", "<Left>", ':echo "Use h"', opts)
keymap("n", "<Right>", ':echo "Use l"', opts)
keymap("n", "<Up>", ':echo "Use k"', opts)
keymap("n", "<Down>", ':echo "Use j"', opts)

-- Tabs
-- Close tabs to the right
keymap("n", "<Leader>tcr", ":.+1,$tabdo :tabc<CR>", opts)
keymap("n", "<Leader>tc", ":tabclose<CR>", opts)
keymap("n", "<Leader>tn", ":tabedit<CR>", opts)
keymap("n", "<Leader>hs", ":sp<CR>", opts)
keymap("n", "<Leader>vs", ":vsp<CR>", opts)

-- Numbered tabs
keymap("n", "<Leader>1", ":LualineBuffersJump 1<CR>", opts)
keymap("n", "<Leader>2", ":LualineBuffersJump 2<CR>", opts)
keymap("n", "<Leader>3", ":LualineBuffersJump 3<CR>", opts)
keymap("n", "<Leader>4", ":LualineBuffersJump 4<CR>", opts)
keymap("n", "<Leader>5", ":LualineBuffersJump 5<CR>", opts)
keymap("n", "<Leader>6", ":LualineBuffersJump 6<CR>", opts)
keymap("n", "<Leader>7", ":LualineBuffersJump 7<CR>", opts)
keymap("n", "<Leader>8", ":LualineBuffersJump 8<CR>", opts)
keymap("n", "<Leader>9", ":LualineBuffersJump 9<CR>", opts)
keymap("n", "<Leader>0", ":LualineBuffersJump 10<CR>", opts)

-- Move tab to left
keymap("n", "<Leader>th", ":tabm -1<CR>", opts)

-- Move tab to right
keymap("n", "<Leader>tl", ":tabm +1<CR>", opts)

-- Go to previous tab
keymap("n", "<Leader>h", "gT<CR>", opts)

-- Go to next tab
keymap("n", "<Leader>l", "gt<CR>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<Leader>.", ":bd<CR>", opts)

-- Paste from clipboard
keymap("n", "<D-v>", '"+p', opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
