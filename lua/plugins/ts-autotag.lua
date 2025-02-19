return {
	"windwp/nvim-ts-autotag",
	event = "InsertEnter",
	config = function()
		require("nvim-ts-autotag").setup({
			enable = true,
			filetypes = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "xml" }, -- (Optional) Define filetypes manually
		})
	end,
}
