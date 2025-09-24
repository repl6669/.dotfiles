return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      hijack_netrw_behavior = "open_current", -- "open_default" or "open_current" or "disabled",
    },
  },
  keys = {
    {
      "-",
      function()
        local bufname = vim.api.nvim_buf_get_name(0)
        local dir
        if bufname ~= "" then
          local grandparent = vim.fn.fnamemodify(bufname, ":p:h:h")
          if vim.fn.isdirectory(grandparent) == 1 then
            dir = grandparent
          else
            dir = vim.fn.fnamemodify(bufname, ":p:h")
          end
        else
          dir = (vim.uv or vim.loop).cwd()
        end

        local file = bufname ~= "" and vim.fn.fnamemodify(bufname, ":p") or nil
        require("neo-tree.command").execute({
          position = "current",
          dir = dir,
          reveal_file = file,
        })
      end,
      { noremap = true, silent = true },
    },
  },
}
