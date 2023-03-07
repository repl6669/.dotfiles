return {
  "epwalsh/obsidian.nvim",
  ft = "markdown",
  opts = {
    dir = os.getenv("OBSIDIAN"),
    notes_subdir = "Zettelkasten",
    daily_notes = {
      folder = "Zettelkasten",
    },
    completion = {
      nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
    },
  },
  config = function()
    vim.keymap.set("n", "gf", function()
      if require("obsidian").util.cursor_on_markdown_link() then
        return "<cmd>ObsidianFollowLink<CR>"
      else
        return "gf"
      end
    end, { noremap = false, expr = true })
  end,
}
