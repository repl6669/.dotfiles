-- Spaceduck theme
-- local colorscheme = "spaceduck"

-- Tokyo night theme
-- local colorscheme = "tokyonight"
-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_italic_functions = true

-- Challenger deep theme
local colorscheme = "challenger_deep"
vim.g.challenger_deep_termcolors = 1

-- Lucid theme
-- local colorscheme = "lucid"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
