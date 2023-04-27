return {
  "jackMort/pommodoro-clock.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("pommodoro-clock").setup({
      modes = {
        ["work"] = { "POMMODORO", 60 },
        ["short_break"] = { "SHORT BREAK", 10 },
        ["long_break"] = { "LONG BREAK", 30 },
      },
      animation_duration = 300,
      animation_fps = 30,
      say_command = "spd-say -l en -t female3",
      sound = "none", -- set to "none" to disable
    })
  end,
  keys = {
    -- stylua: ignore
    { "<leader>pw", function () require('pommodoro-clock').start("work") end, desc = "Start Pommodoro", },
    -- stylua: ignore
    { "<leader>ps", function () require('pommodoro-clock').start("short_break") end, desc = "Short Break", },
    -- stylua: ignore
    { "<leader>pl", function () require('pommodoro-clock').start("long_break") end, desc = "Long Break", },
    -- stylua: ignore
    { "<leader>pp", function () require('pommodoro-clock').start("toggle_pause") end, desc = "Toggle Pause", },
    -- stylua: ignore
    { "<leader>pc", function () require('pommodoro-clock').start("close") end, desc = "Close", },
  },
}
