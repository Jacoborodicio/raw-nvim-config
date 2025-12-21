return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		checkbox = {
			unchecked = { icon = "[ ] " },
			checked = { icon = "[✔] " },
			custom = { todo = { raw = "[todo]", rendered = "◯ab " } },
			enabled = true,
			render_modes = false,
			position = "inline",
		},
		heading = {
			position = 'inline',
		}
	},
}
