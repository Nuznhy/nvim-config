return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	opts = {
		notification = {
			window = {
				border = "rounded",
				border_hl = "FloatBorder",
				normal_hl = "NormalFloat",
				winblend = 0,
			},
		},
		progress = {
			suppress_on_insert = true, -- Suppress new messages while in insert mode
		},
	},
}
