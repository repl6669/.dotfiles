return {
  "j-hui/fidget.nvim",
  opts = {
    progress = {
      display = {
        done_ttl = 5, -- How long a message should persist after completion
      },
    },
    notification = {
      window = {
        winblend = 0, -- Background color opacity in the notification window
        y_padding = 1,
      },
    },
  },
}
