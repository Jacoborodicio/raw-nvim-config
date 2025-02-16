return { -- Autocompletion
	"hrsh7th/nvim-cmp",
	-- event = 'InsertEnter',
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				-- `friendly-snippets` contains a variety of premade snippets.
				--    See the README about individual language/framework/plugin snippets:
				--    https://github.com/rafamadriz/friendly-snippets
				-- {
				--   'rafamadriz/friendly-snippets',
				--   config = function()
				--     require('luasnip.loaders.from_vscode').lazy_load()
				--   end,
				-- },
			},

			config = function()
				local ls = require("luasnip")
				local s = ls.snippet
				local t = ls.text_node
				local i = ls.insert_node
				local rep = require("luasnip.extras").rep
				local fmt = require("luasnip.extras.fmt").fmt

				-- Define un snippet básico para TODOS los archivos
				ls.add_snippets("all", {
					s("cl", fmt("console.log('%c 🚀 {} 🚀', 'color:coral');", { i(1, "here") })),
					s(
						"cls",
						fmt(
							"console.log('%c 🔰 {} 🔰:', 'color:lightblue', {});",
							{ rep(1), i(1, "default_value") }
						)
					),
					s(
						"clg",
						fmt("console.group('🔻🔻 {} 🔻🔻')\n\t{}\nconsole.groupEnd();", { i(1, "name"), i(0) })
					),
					s(
						"clt",
						fmt(
							"console.time('🔻🔻 {} 🔻🔻')\n\nconsole.timeEnd('🔻🔻 {} 🔻🔻');",
							{ i(1, "functionName"), rep(1) }
						)
					),
				})

				-- Define el snippet para React Functional Component
				ls.add_snippets("javascript", {
					s("rfc", {
						t({ "import React from 'react';", "import PropTypes from 'prop-types';", "", "const " }),
						i(1, "ComponentName"), -- Prompt interactivo para el nombre del componente
						t({ " = () => {", "return (" }),
						t({ "", "\t<div>", "\t\t" }),
						rep(1),
						t({ " component", "\t</div>", " );", "};", "", "" }),
						t(""),
						rep(1),
						t(".propTypes = {};"),
						t({ "", "", "export default " }),
						rep(1),
						t(";"),
					}),
				})

				-- Atajos básicos para expandir y navegar por los snippets
				vim.keymap.set({ "i", "s" }, "<CR>", function()
					if ls.jumpable(1) then
						ls.jump(1)
					else
						return "<CR>"
					end
				end, { expr = true, silent = true })

				vim.keymap.set({ "i", "s" }, "<C-K>", function()
					if ls.expand_or_jumpable() then
						ls.expand_or_jump()
					end
				end, { silent = true })

				vim.keymap.set({ "i", "s" }, "<C-J>", function()
					if ls.jumpable(-1) then
						ls.jump(-1)
					end
				end, { silent = true })
			end,
		},

		"saadparwaiz1/cmp_luasnip",

		-- Adds other completion capabilities.
		--  nvim-cmp does not ship with all sources by default. They are split
		--  into multiple repos for maintenance purposes.
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
	},
	config = function()
		-- See `:help cmp`
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		luasnip.config.setup({})
		local kind_icons = {
			Text = "󰉿",
			Method = "m",
			Function = "󰊕",
			Constructor = "",
			Field = "",
			Variable = "󰆧",
			Class = "󰌗",
			Interface = "",
			Module = "",
			Property = "",
			Unit = "",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰇽",
			Struct = "",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "󰊄",
		}

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },

			-- For an understanding of why these mappings were
			-- chosen, you will need to read `:help ins-completion`
			--
			-- No, but seriously. Please read `:help ins-completion`, it is really good!
			mapping = cmp.mapping.preset.insert({
				-- Select the [n]ext item
				["<C-n>"] = cmp.mapping.select_next_item(),
				-- Select the [p]revious item
				["<C-p>"] = cmp.mapping.select_prev_item(),

				-- Scroll the documentation window [b]ack / [f]orward
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),

				-- Accept ([y]es) the completion.
				--  This will auto-import if your LSP supports it.
				--  This will expand snippets if the LSP sent a snippet.
				-- TODO: Change it to CR? See if it conflicts to other stuff
				-- ['<C-y>'] = cmp.mapping.confirm { select = true },
				["<CR>"] = cmp.mapping.confirm({ select = true }),

				-- If you prefer more traditional completion keymaps,
				-- you can uncomment the following lines
				--['<CR>'] = cmp.mapping.confirm { select = true },
				--['<Tab>'] = cmp.mapping.select_next_item(),
				--['<S-Tab>'] = cmp.mapping.select_prev_item(),

				-- Manually trigger a completion from nvim-cmp.
				--  Generally you don't need this, because nvim-cmp will display
				--  completions whenever it has completion options available.
				["<C-Space>"] = cmp.mapping.complete({}),

				-- Think of <c-l> as moving to the right of your snippet expansion.
				--  So if you have a snippet that's like:
				--  function $name($args)
				--    $body
				--  end
				--
				-- <c-l> will move you to the right of each of the expansion locations.
				-- <c-h> is similar, except moving you backwards.
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),

				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
			}),
			sources = {
				{
					name = "lazydev",
					-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
					group_index = 0,
				},
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						buffer = "[Buffer]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
		})
	end,
}
