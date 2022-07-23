require('auto-session').setup {
    -- auto_save_enabled = true,
    -- auto_session_create_enabled = false,
    auto_session_suppress_dirs = { "./vendor/*", "./node_modules/*" },
}

require('session-lens').setup {
}
