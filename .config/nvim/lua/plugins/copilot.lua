-- Copilot with CMP
-- return {
--
--   -- Copilot
--   {
--     "zbirenbaum/copilot.lua",
--     cmd = "Copilot",
--     build = ":Copilot auth",
--     opts = {
--       suggestion = { enabled = false },
--       panel = { enabled = false },
--     },
--   },
--
--   -- Copilot cmp source
--   {
--     "nvim-cmp",
--     dependencies = {
--       {
--         "zbirenbaum/copilot-cmp",
--         dependencies = "copilot.lua",
--         opts = {},
--         config = function(_, opts)
--           local copilot_cmp = require("copilot_cmp")
--           copilot_cmp.setup(opts)
--           -- attach cmp source whenever copilot attaches
--           -- fixes lazy-loading issues with the copilot cmp source
--           require("lazyvim.util").on_attach(function(client)
--             if client.name == "copilot" then
--               copilot_cmp._on_insert_enter()
--             end
--           end)
--         end,
--       },
--     },
--     ---@param opts cmp.ConfigSchema
--     opts = function(_, opts)
--       local cmp = require("cmp")
--       opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "copilot" } }))
--     end,
--   },
-- }

-- Copilot

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      panel = {
        auto_refresh = false,
        keymap = {
          accept = "<CR>",
          jump_prev = "[[",
          jump_next = "]]",
          refresh = "gr",
          open = "<D-CR>",
        },
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<D-l>",
          prev = "<D-[>",
          next = "<D-]>",
          dismiss = "<C-]>",
        },
      },
    })
  end,
}
