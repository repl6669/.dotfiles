if vim.g.neovide then
  -- Set up font
  vim.opt.guifont = { "JetBrainsMono Nerd Font", ":h18" }
  -- vim.opt.linespace = 4

  -- vim.g.neovide_transparency = 0.0
  -- vim.g.transparency = 0.90
  -- vim.g.neovide_background_color = "#191723" .. alpha()

  -- The transparency rendering on macOS has been changed, and a full fix is work in progress.
  vim.g.neovide_transparency = 0.85
  vim.g.neovide_window_blurred = true

  -- vim.g.neovide_remember_window_size = false

  vim.g.neovide_theme = "auto"
  vim.g.winblend = 0

  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  -- Disable cursor animation
  vim.g.neovide_cursor_animation_length = 0

  -- Set scroll animation length
  vim.g.neovide_scroll_animation_length = 0.125

  -- Enable cursor ripple effect
  vim.g.neovide_cursor_vfx_mode = "ripple"

  -- Remember window size
  vim.g.neovide_remember_window_size = true

  vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end
