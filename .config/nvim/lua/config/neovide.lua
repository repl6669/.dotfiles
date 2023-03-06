if vim.g.neovide then
  -- Set up font
  vim.opt.guifont = { "DankMono Nerd Font Mono", ":h18" }

  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * 0.9))
  end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 0.0
  vim.g.transparency = 0.9
  vim.g.neovide_background_color = "#1f1e2f" .. alpha()

  -- Light theme settings
  -- vim.opt.background = "light"
  -- vim.g.neovide_background_color = "#ffffff" .. alpha()

  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  -- Disable cursor animation
  vim.g.neovide_cursor_animation_length = 0

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
