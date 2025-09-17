return {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/phpactor", "language-server" },
  filetypes = { "php" },
  root_markers = {
    "composer.json",
    ".git",
    ".phpactor.json",
    ".phpactor.yml",
  },
  -- Essential settings for phpactor
  settings = {
    phpactor = {
      completion = { enabled = true },
      hover = { enabled = true },
      references = { enabled = true },
      diagnostics = { enabled = true },
    },
  },
}
