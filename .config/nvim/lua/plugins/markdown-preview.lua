-- Markdown previews in browser
return {
  "iamcco/markdown-preview.nvim",
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    local opts = { noremap = true, silent = true }

    -- Markdown Preview
    vim.keymap.set("n", "<Leader>mp", "<Plug>MarkdownPreview", opts)
    vim.keymap.set("n", "<Leader>mps", "<Plug>MarkdownPreviewStop", opts)
    vim.keymap.set("n", "<Leader>mpt", "<Plug>MarkdownPreviewToggle", opts)
  end,
}
