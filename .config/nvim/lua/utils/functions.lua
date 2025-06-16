local M = {}

function M.map(tbl, fn)
  local result = {}
  for i, v in ipairs(tbl) do
    result[i] = fn(v, i)
  end
  return result
end

--- @alias TextareaCallback fun(first_line: string?, full_text: string?): nil

---@param callback TextareaCallback
function M.open_textarea(callback)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].filetype = "markdown"
  local width = 100
  local height = 30
  local win_opts = {
    relative = "editor",
    width = width,
    height = height,
    row = (vim.o.lines - height) / 2,
    col = (vim.o.columns - width) / 2,
    style = "minimal",
    border = vim.o.winborder,
  }

  local win = vim.api.nvim_open_win(buf, true, win_opts)

  vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "", {
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      vim.api.nvim_win_close(win, true)
      callback(lines[1], table.concat(lines, "\n"))
    end,
    noremap = true,
    silent = true,
  })

  -- Optional: Esc to cancel
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "", {
    callback = function()
      vim.api.nvim_win_close(win, true)
      vim.notify("Adding reference canceled")
    end,
    noremap = true,
    silent = true,
  })
end

return M
