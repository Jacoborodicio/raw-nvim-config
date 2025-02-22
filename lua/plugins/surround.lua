return {
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"tpope/vim-repeat", -- ✅ Enables repeatable actions for plugins like nvim-surround
		event = "VeryLazy",
	},
}
