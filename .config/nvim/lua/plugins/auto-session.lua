-- Session management
return {
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({
      -- auto_save_enabled = true,
      -- auto_session_create_enabled = false,
      auto_session_suppress_dirs = {
        "~/",
        "/",
        "~/Developer",
        "~/Downloads",
        "./vendor/*",
        "./node_modules/*",
      },
    })
  end,
}
