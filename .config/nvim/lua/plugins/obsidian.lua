return {
  "epwalsh/obsidian.nvim",
  enabled = false,
  ft = "markdown",
  version = "*",
  ui = {
    enable = false,
    -- hl_groups = require("repl69.plugins.obsidian"),
  },
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    "BufReadPre /Users/theimer/Library/Mobile Documents/iCloud~md~obsidian/Documents/obsidian/**.md",
    "BufNewFile /Users/theimer/Library/Mobile Documents/iCloud~md~obsidian/Documents/obsidian/**.md",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "/Users/theimer/Library/Mobile Documents/iCloud~md~obsidian/Documents/obsidian",
      },
    },
    use_advanced_uri = true,
    notes_subdir = "Zettelkasten",
    daily_notes = {
      folder = "Zettelkasten",
    },
    templates = {
      subdir = "Templates",
      date_format = "%Y%m%d",
      time_format = "%H:%M",
    },
    completion = {},
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    -- Optional, set to true if you don't want Obsidian to manage frontmatter.
    disable_frontmatter = true,
  },
  keys = {
    { "<leader>ob", ":ObsidianBacklinks<cr>", desc = "Get List of References" }, -- for getting a location list of references to the current buffer.
    { "<leader>ot", ":ObsidianToday<cr>", desc = "Create Daily Note" }, -- to create a new daily note.
    { "<leader>oy", ":ObsidianYesterday<cr>", desc = "Open or Create Note for Previous Working Day" }, -- to open (eventually creating) the daily note for the previous working day.
    { "<leader>oo", ":ObsidianOpen<cr>", desc = "Open Note in Obsidian app" }, -- to open a note in the Obsidian app. This command has one optional argument: the ID, path, or alias of the note to open. If not given, the note corresponding to the current buffer is opened.
    { "<leader>oc", ":ObsidianNew ", desc = "Create New Note" }, -- to create a new note. This command has one optional argument: the title of the new note.
    { "<leader>oC", ":ObsidianNew<cr>", desc = "Create New Random Note" }, -- to create a new note. This command has one optional argument: the title of the new note.
    { "<leader>os", ":ObsidianSearch<cr>", desc = "Search Notes" }, -- to search for notes in your vault using ripgrep with fzf.vim, fzf-lua or telescope.nvim. This command has one optional argument: a search query to start with.
    { "<leader>of", ":ObsidianQuickSwitch<cr>", desc = "Switch Notes" }, -- to quickly switch to another notes in your vault, searching by its name using fzf.vim, fzf-lua or telescope.nvim.
    { "<leader>ol", ":ObsidianLink ", mode = { "n" }, desc = "Link Note" }, -- to link an in-line visual selection of text to a note. This command has one optional argument: the ID, path, or alias of the note to link to. If not given, the selected text will be used to find the note with a matching ID, path, or alias.
    { "<leader>ol", ":ObsidianLink<cr>", mode = { "v" }, desc = "Link Note with Selection" }, -- to link an in-line visual selection of text to a note. This command has one optional argument: the ID, path, or alias of the note to link to. If not given, the selected text will be used to find the note with a matching ID, path, or alias.
    { "<leader>oa", ":ObsidianLinkNew ", mode = { "n" }, desc = "Create Link" }, -- to create a new note and link it to an in-line visual selection of text. This command has one optional argument: the title of the new note. If not given, the selected text will be used as the title.
    { "<leader>oa", ":ObsidianLinkNew<cr>", mode = { "v" }, desc = "Create Link with Selection" }, -- to create a new note and link it to an in-line visual selection of text. This command has one optional argument: the title of the new note. If not given, the selected text will be used as the title.
    { "<leader>og", ":ObsidianFollowLink<cr>", desc = "Follow Link to Note" }, -- to follow a note reference under the cursor.
    { "<leader>ot", ":ObsidianTemplate<cr>", desc = "Insert Template" }, -- to follow a note reference under the cursor.
  },
}
