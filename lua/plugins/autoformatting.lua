return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jayp0521/mason-null-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local diagnostics = null_ls.builtins.diagnostics

		-- Only linters here — formatters are installed via mason-tool-installer in lsp.lua
		require("mason-null-ls").setup({
			ensure_installed = {
				"eslint_d",      -- ts/js linter
				"checkmake",     -- linter for Makefiles
				"golangci_lint", -- linter for Go
			},
			automatic_installation = true,
		})

		null_ls.setup({
			sources = {
				diagnostics.checkmake,
				require("none-ls.diagnostics.eslint_d"),
			},
		})
	end,
}
