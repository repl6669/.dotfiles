return {
  cmd = { "emmet-language-server", "--stdio" },
  filetypes = {
    "astro",
    "css",
    "eruby",
    "blade",
    "html",
    "htmlangular",
    "htmldjango",
    "javascriptreact",
    "less",
    "pug",
    "sass",
    "scss",
    "svelte",
    "templ",
    "typescriptreact",
    "vue",
  },
  root_dir = function(fname)
    return vim.fs.root(fname, { ".git", "package.json", "tsconfig.json", "nuxt.config.js", "nuxt.config.ts" })
  end,
  settings = {
    emmet = {
      includeLanguages = {
        vue = "html",
        javascript = "javascriptreact",
        typescript = "typescriptreact",
      },
    },
  },
  init_options = {
    includeLanguages = {
      vue = "html",
      javascript = "javascriptreact",
      typescript = "typescriptreact",
    },
  },
}
