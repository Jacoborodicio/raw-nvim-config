return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local mode = {
			"mode",
			fmt = function(str)
				-- return ' ' .. str
				return " " .. str:sub(1, 1) -- displays only the first character of the mode
			end,
		}

		local filename = {
			"filename",
			file_status = true, -- displays file status (readonly status, modified status)
			path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
		}

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			colored = false,
			update_in_insert = false,
			always_visible = false,
			cond = hide_in_width,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			cond = hide_in_width,
		}

		require("lualine").setup({
			options = {
				globalstatus = true,
				icons_enabled = true,
				-- theme = 'nord', -- Set theme based on environment variable
				-- theme = "iceberg_dark",
				theme = {
					normal = { c = { fg = "#ffffff", bg = "NONE" } }, -- Transparent background
					insert = { c = { fg = "#ffffff", bg = "NONE" } },
					visual = { c = { fg = "#ffffff", bg = "NONE" } },
					replace = { c = { fg = "#ffffff", bg = "NONE" } },
					command = { c = { fg = "#ffffff", bg = "NONE" } },
					inactive = { c = { fg = "#888888", bg = "NONE" } },
				},
				-- Some useful glyphs:
				-- https://www.nerdfonts.com/cheat-sheet
				--        
				-- section_separators = { left = '', right = '' },
				-- component_separators = { left = '', right = '' },
				section_separators = { left = " ", right = " " },
				component_separators = { left = "|", right = "|" },
				disabled_filetypes = { "alpha", "neo-tree" },
				always_divide_middle = true,
				-- section_separators = { left = '', right = '' },
				-- component_separators = { left = '', right = '' },
				-- disabled_filetypes = { 'alpha', 'neo-tree' },
				-- always_divide_middle = true,
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { "branch" },
				lualine_c = { filename },
				lualine_x = {
					diagnostics,
					diff,
					{ "encoding", cond = hide_in_width },
					{ "filetype", cond = hide_in_width },
				},
				lualine_y = { "location" },
				lualine_z = { "progress" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { { "location", padding = 0 } },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "fugitive", "neo-tree" },
		})
	end,
}
