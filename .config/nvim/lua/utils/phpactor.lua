-- Native phpactor RPC implementation for Neovim 0.11
-- Replaces gbprod/phpactor.nvim plugin entirely

local M = {}

M.config = {
  phpactor_bin = vim.fn.stdpath("data") .. "/mason/packages/phpactor/phpactor.phar",
  php_bin = "php",
  -- php_bin = "docker compose -f ../compose.local.yml exec api php", -- for Docker
}

-- Utility functions
local utils = {}

function utils.offset(winnr, bufnr)
  winnr = winnr or 0
  bufnr = bufnr or 0
  local cursor = vim.api.nvim_win_get_cursor(winnr)
  return vim.api.nvim_buf_get_offset(bufnr, cursor[1] - 1) + cursor[2] + 1
end

function utils.source(bufnr)
  bufnr = bufnr or 0
  return vim.fn.join(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
end

function utils.path(bufnr)
  bufnr = bufnr or 0
  
  -- regular file
  if vim.api.nvim_get_option_value("buftype", { buf = bufnr }) == "" then
    return vim.api.nvim_buf_get_name(bufnr) or vim.uv.cwd()
  end
  
  -- neo-tree support
  if vim.api.nvim_get_option_value("filetype", { buf = bufnr }) == "neo-tree" then
    local ok, state = pcall(require, "neo-tree.sources.manager")
    if ok then
      local tree_state = state.get_state("filesystem")
      if tree_state and tree_state.tree then
        return tree_state.tree:get_node().path
      end
    end
  end
  
  return vim.uv.cwd()
end

function utils.get_root_dir()
  -- Try to get root from phpactor LSP client
  local clients = vim.lsp.get_clients({ name = "phpactor", bufnr = 0 })
  if #clients > 0 then
    return clients[1].config.root_dir or vim.uv.cwd()
  end
  
  -- Fallback to current working directory
  return vim.uv.cwd()
end

function utils.open_message_win(content)
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
  
  vim.api.nvim_open_win(bufnr, true, {
    relative = "win",
    style = "minimal",
    row = math.floor(vim.o.lines * 0.05),
    height = math.floor(vim.o.lines * 0.9),
    col = math.floor(vim.o.columns * 0.05),
    width = math.floor(vim.o.columns * 0.9),
    border = "single",
  })
end

function utils.get_default_register()
  local clipboard_flags = vim.split(vim.o.clipboard, ",")
  if vim.tbl_contains(clipboard_flags, "unnamedplus") then
    return "+"
  end
  
  if vim.tbl_contains(clipboard_flags, "unnamed") then
    return "*"
  end
  
  return '"'
end

-- Core RPC functionality
function M.call(action, parameters, options)
  options = options or {}
  local request = { action = action, parameters = parameters }
  
  local workspace_dir = utils.get_root_dir()
  
  local cmd = string.format(
    '%s %s rpc --working-dir "%s"',
    M.config.php_bin,
    M.config.phpactor_bin,
    workspace_dir
  )
  
  local result = vim.fn.system(cmd, vim.fn.json_encode(request))
  
  if vim.v.shell_error ~= 0 then
    vim.notify("Phpactor error: " .. result, vim.log.levels.ERROR, { title = "phpactor" })
    return
  end
  
  local response = vim.fn.json_decode(result)
  local handler_name = "handle_" .. response.action
  
  if M[handler_name] == nil then
    vim.notify(
      "Unknown phpactor action: " .. response.action,
      vim.log.levels.ERROR,
      { title = "phpactor" }
    )
    return
  end
  
  return M[handler_name](response.parameters, options)
end

-- Response handlers
function M.handle_return(parameters, options)
  if options.callback then
    options.callback(parameters.value)
  end
end

function M.handle_return_choice(parameters, options)
  vim.ui.select(vim.tbl_values(parameters.choices), {
    format_item = function(item)
      return item.name
    end,
  }, function(item)
    if item and options.callback then
      options.callback(item.value)
    end
  end)
end

function M.handle_collection(parameters, options)
  for _, action in pairs(parameters.actions) do
    local handler_name = "handle_" .. action.name
    
    if M[handler_name] == nil then
      vim.notify(
        "Unknown phpactor action: " .. action.name,
        vim.log.levels.ERROR,
        { title = "phpactor" }
      )
    else
      M[handler_name](action.parameters, options)
    end
  end
end

function M.handle_echo(parameters, options)
  options = options or {}
  if options.echo_mode == "float" then
    utils.open_message_win(vim.split(parameters.message, "\n", {}))
  else
    vim.notify(parameters.message, vim.log.levels.INFO, { title = "phpactor" })
  end
end

function M.handle_error(parameters)
  vim.notify(parameters.message, vim.log.levels.ERROR, { title = "phpactor" })
end

function M.handle_update_file_source(parameters)
  for _, edit in pairs(parameters.edits) do
    local bufnr = vim.fn.bufadd(parameters.path)
    
    vim.api.nvim_buf_set_lines(
      bufnr,
      edit.start.line,
      edit["end"].line,
      false,
      vim.split(edit.text:gsub("\n$", ""), "\n", {})
    )
  end
end

function M.handle_input_callback(parameters)
  local input = table.remove(parameters.inputs)
  
  if input.type == "list" or input.type == "choice" then
    vim.ui.select(vim.tbl_values(input.parameters.choices), { 
      prompt = input.parameters.label 
    }, function(item)
      if item then
        parameters.callback.parameters[input.name] = item
        M.call(parameters.callback.action, parameters.callback.parameters)
      end
    end)
    return
  end
  
  if input.type == "text" then
    local opts = { 
      prompt = input.parameters.label, 
      default = input.parameters.default 
    }
    if input.parameters.type == "file" then
      opts.completion = "file"
    end
    
    vim.ui.input(opts, function(item)
      if item then
        parameters.callback.parameters[input.name] = item
        M.call(parameters.callback.action, parameters.callback.parameters)
      end
    end)
    return
  end
  
  if input.type == "confirm" then
    vim.ui.select({ "Yes", "No" }, { 
      prompt = input.parameters.label 
    }, function(item)
      if item == "Yes" then
        parameters.callback.parameters[input.name] = true
        M.call(parameters.callback.action, parameters.callback.parameters)
      end
    end)
    return
  end
  
  vim.notify("Unknown input type: " .. input.type, vim.log.levels.ERROR, { title = "phpactor" })
end

function M.handle_close_file(parameters)
  local bufnr = vim.fn.bufnr(parameters.path .. "$")
  if bufnr ~= -1 then
    vim.api.nvim_buf_delete(bufnr, {})
  end
end

function M.handle_open_file(parameters, options)
  local target = options.target or parameters.target or "edit"
  local bufnr = vim.fn.bufnr(parameters.path .. "$")
  
  if bufnr ~= -1 and target == "focused_window" then
    vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), bufnr)
    return
  end
  
  -- Convert target to vim command
  local open_cmd = target
  if target == "focused_window" then
    open_cmd = "edit"
  elseif target == "hsplit" then
    open_cmd = "split"
  elseif target == "new_tab" then
    open_cmd = "tabedit"
  end
  
  vim.cmd(string.format("%s %s", open_cmd, vim.fn.fnameescape(parameters.path)))
  
  if bufnr ~= -1 and parameters.force_reload then
    vim.cmd("edit!")
  end
  
  if parameters.offset then
    vim.cmd(string.format("goto %s", parameters.offset + 1))
  end
end

function M.handle_replace_file_source(parameters)
  local bufnr = vim.fn.bufnr(parameters.path .. "$")
  
  if bufnr == -1 then
    vim.cmd(string.format("edit %s", vim.fn.fnameescape(parameters.path)))
    bufnr = vim.fn.bufnr(parameters.path .. "$")
  end
  
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, vim.split(parameters.source, "\n", {}))
end

function M.handle_information(parameters)
  utils.open_message_win(vim.split(parameters.information, "\n", {}))
end

-- High-level command functions
function M.context_menu()
  M.call("context_menu", {
    offset = utils.offset(),
    source = utils.source(),
    current_path = utils.path(),
  })
end

function M.import_class()
  M.call("import_class", {
    offset = utils.offset(),
    source = utils.source(),
    current_path = utils.path(),
  })
end

function M.import_missing_classes()
  M.call("import_missing_classes", {
    source = utils.source(),
    current_path = utils.path(),
  })
end

function M.new_class()
  M.call("class_new", {
    current_path = utils.path(),
  })
end

function M.change_visibility()
  M.call("change_visibility", {
    offset = utils.offset(),
    source = utils.source(),
    current_path = utils.path(),
  })
end

function M.expand_class()
  M.call("expand_class", {
    offset = utils.offset(),
    source = utils.source(),
    current_path = utils.path(),
  })
end

function M.transform()
  M.call("transform", {
    offset = utils.offset(),
    source = utils.source(),
    current_path = utils.path(),
  })
end

function M.copy_class()
  M.call("copy_class", {
    offset = utils.offset(),
    source = utils.source(),
    current_path = utils.path(),
  }, {
    callback = function(class_name)
      vim.fn.setreg(utils.get_default_register(), class_name)
      vim.notify("Copied: " .. class_name, vim.log.levels.INFO, { title = "phpactor" })
    end
  })
end

function M.cache_clear()
  M.call("cache_clear", {})
end

function M.status()
  M.call("status", {}, { echo_mode = "float" })
end

function M.reindex()
  vim.lsp.buf_notify(0, "phpactor/indexer/reindex", {})
  vim.notify("Reindexing started", vim.log.levels.INFO, { title = "PhpActor" })
end

-- Expose utils for external use
M.utils = utils

return M