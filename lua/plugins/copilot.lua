return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot", -- Load only when needed
	event = "InsertEnter", -- Load on insert mode
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true, -- Automatically trigger suggestions
				debounce = 150, -- Adjust debounce for responsiveness
				keymap = {
					accept = "<Tab>", -- Accept suggestion
					next = "<C-j>", -- Next suggestion
					prev = "<C-k>", -- Previous suggestion
					dismiss = "<C-]>", -- Dismiss suggestion
				},
			},
			panel = { enabled = true },
			filetypes = {
				yaml = true,
				markdown = true,
				help = false, -- Disable Copilot in help files
				gitcommit = true,
				gitrebase = false,
				hgcommit = false,
			},
		})
	end,
}
