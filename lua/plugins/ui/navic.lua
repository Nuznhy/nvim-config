return {
	"SmiteshP/nvim-navic",
	dependencies = "neovim/nvim-lspconfig",
	opts = {
		highlight = true,
		lsp = { auto_attach = true },
		separator = " › ",
	},
	config = function(_, opts)
		require("nvim-navic").setup(opts)
	end,
}
