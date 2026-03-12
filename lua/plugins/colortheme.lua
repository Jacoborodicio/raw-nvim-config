return {
	"shaunsingh/nord.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.nord_contrast = true
		vim.g.nord_borders = false
		vim.g.nord_disable_background = true
		vim.g.nord_italic = false
		vim.g.nord_uniform_diff_background = true
		vim.g.nord_bold = false

		-- Load the colorscheme
		require("nord").set()

		-- Toggle background transparency
		local bg_transparent = true

		local toggle_transparency = function()
			bg_transparent = not bg_transparent
			vim.g.nord_disable_background = bg_transparent
			vim.cmd([[colorscheme nord]])
		end

		vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true })
		vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ffffff", bg = "#000000", bold = true })

		-- render-markdown callout highlights (vibrant for dark themes)
		vim.api.nvim_set_hl(0, "RenderMarkdownInfo", { fg = "#5ec4ff", bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownHint", { fg = "#c792ea", bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownWarn", { fg = "#ffcc00", bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownQuote", { fg = "#8a8a8a", italic = true })
	end,
}
