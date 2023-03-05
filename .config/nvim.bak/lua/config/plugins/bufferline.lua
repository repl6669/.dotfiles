-- Buffer line
return {
	"akinsho/bufferline.nvim",
	version = "v3.*",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	config = function()
		require("bufferline").setup({
			highlights = require("catppuccin.groups.integrations.bufferline").get(),
			options = {
				indicator = {
					icon = " ",
					style = "none",
				},
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local s = " "
					for e, n in pairs(diagnostics_dict) do
						local sym = e == "error" and " " or (e == "warning" and " " or " ")
						s = s .. n .. sym
					end
					return s
				end,
				show_buffer_close_icons = false,
				show_close_icon = false,
				tab_size = 0,
				max_name_length = 25,

				offsets = {
					{
						filetype = "NvimTree",
						text = "  Files",
						highlight = "StatusLine",
						text_align = "left",
					},
				},
				separator_style = "thin",
				modified_icon = "",
				custom_areas = {
					left = function()
						return {
							{ text = "    ", fg = "#8fff6d" },
						}
					end,
				},
			},
		})
	end,
}
