return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
    local actions = require("fzf-lua").actions

    return vim.tbl_deep_extend("force", opts, {
      fzf_colors = {
        true,
        bg = "-1",
        gutter = "-1", -- I like this one too, try with and without
      },
      oldfiles = {
        include_current_session = true,
      },
      previewers = {
        builtin = {
          -- With this change, the previewer will not add syntax highlighting to files larger than 100KB
          syntax_limit_b = 1024 * 100, -- 100KB
        },
      },
      files = {
        cwd_prompt = false,
        actions = {
          ["ctrl-i"] = { actions.toggle_ignore },
          ["ctrl-h"] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ["ctrl-i"] = { actions.toggle_ignore },
          ["ctrl-h"] = { actions.toggle_hidden },
        },
      },
    })
  end,
}
