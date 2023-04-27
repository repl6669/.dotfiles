return {
  "folke/neodev.nvim",
  opts = {
    library = {
      plugins = { "neotest", "nvim-dap-ui" },
      types = true,
    },
    experimental = {
      pathStrict = true,
    },
  },
}
