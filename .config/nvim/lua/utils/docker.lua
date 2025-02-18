local logger = require("neotest.logging")

local M = {
  docker_compose_files = {
    "docker-compose.yml",
    "docker-compose.yaml",
    "compose.local.yml",
    "compose.local.yaml",
  },
  _docker_error = false,
  _docker_enabled = false,
}

function M.docker_enabled()
  if M._docker_enabled then
    return true
  end

  return M.docker_available()
end

function M.docker_available()
  local root = require("lazyvim.util").root.get({ normalize = true })

  for _, file in ipairs(M.docker_compose_files) do
    if
      (vim.fn.filereadable(root .. "/" .. file) == 1)
      or (vim.fn.filereadable(vim.fn.fnamemodify(root, ":h") .. "/" .. file) == 1)
    then
      M._docker_enabled = true
      return true
    end
  end

  M._docker_error = true
  logger.debug("Docker compose file not found")

  return false
end

return M
