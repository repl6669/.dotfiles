return {
  cmd = { "vtsls", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
  on_attach = function(client, bufnr)
    -- disable formatting, since we use prettier
    client.server_capabilities.documentFormattingProvider = false
  end,
  settings = {},
}
