local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local chatgpt = require("chatgpt")

chatgpt.setup({
    -- optional configuration
})
