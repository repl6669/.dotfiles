if true then
  return {}
end

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
