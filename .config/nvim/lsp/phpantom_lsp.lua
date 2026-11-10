-- PHPantom: Rust PHP language server (https://github.com/PHPantom-dev/phpantom_lsp)
-- Installed via Mason. Project config lives in .phpantom.toml.
local root_markers = { ".phpantom.toml", "composer.json", ".git" }

return {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/phpantom_lsp" },
  filetypes = { "php", "blade" },
  -- Files under vendor/ belong to the project that installed them. Without this,
  -- jumping into e.g. vendor/laravel/framework finds that package's composer.json
  -- and spawns a separate server that re-indexes the whole package.
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local project = fname:match("^(.-)/vendor/")
    local root = project or vim.fs.root(bufnr, root_markers)
    if root then
      on_dir(root)
    end
  end,
}
