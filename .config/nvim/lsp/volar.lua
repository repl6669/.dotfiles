return {
  cmd = { "vue-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "json",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "vue",
  },
  root_markers = {
    "vue.config.js",
    "vue.config.ts",
    "nuxt.config.js",
    "nuxt.config.ts",
    "package.json",
    ".git",
  },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
  on_attach = function(client, bufnr)
    -- disable formatting, since we use prettier
    client.server_capabilities.documentFormattingProvider = false
  end,
}
