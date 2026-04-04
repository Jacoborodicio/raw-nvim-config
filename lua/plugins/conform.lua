return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports", "gofumpt" },
			sh = { "shfmt" },
			-- Try biome first (if biome.json present), fall back to prettier
			javascript = { "biome", "prettier" },
			javascriptreact = { "biome", "prettier" },
			typescript = { "biome", "prettier" },
			typescriptreact = { "biome", "prettier" },
			json = { "biome", "prettier" },
			html = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
		},
		notify_on_error = false,
		-- Format on save
		format_on_save = function(_)
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
		-- Only use a formatter if its config file is detected in the project
		formatters = {
			biome = {
				condition = function(_, ctx)
					return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = ctx.filename, upward = true })[1] ~= nil
				end,
			},
		},
	},
}
