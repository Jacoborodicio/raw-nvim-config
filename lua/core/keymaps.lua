-- For conciseness
local opts = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)

-- Remove hightlights when pressing ESC
vim.api.nvim_set_keymap("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })

-- Highlight the text yanked for 200 miliseconds.
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Allow to scape with a fast combination of jk or JK
vim.keymap.set("i", "jk", "<ESC>", opts)
vim.keymap.set("i", "JK", "<ESC>", opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "17<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "17<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>xx", ":bdelete!<CR>", opts) -- close buffer

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Diagnostic key maps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Topic lazy git
vim.api.nvim_set_keymap(
	"n",
	"<leader>gg",
	"<cmd>lua _LazygitToggle()<CR>",
	{ noremap = true, silent = true, desc = "Open Lazy Git" }
)

function _LazygitToggle()
	-- Check if we're inside a Git repository
	local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):gsub("\n", "") == "true"

	if not is_git_repo then
		print("🚫 Not inside a Git repository!")
		return
	end

	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({
		cmd = "lazygit",
		direction = "float", -- Floating window
		hidden = true, -- Doesn't interfere with other terminals
		on_open = function(term)
			vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<cmd>close<CR>", { noremap = true, silent = true })
		end,
	})

	lazygit:toggle()
end

vim.keymap.set("n", "<C-->", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-->", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-->", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-->", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-b>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-b>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-b>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-b>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })

-- It allows to jump to Normal mode from terminal
vim.keymap.set("t", "<C-f>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- It allows to close every opened buffer but the current one
vim.keymap.set("n", "<leader>bd", function()
	local curr = vim.fn.bufnr("%")
	vim.cmd('silent! bufdo if bufnr("%") != ' .. curr .. " | bd | endif")
end, { noremap = true, silent = true, desc = "Close all buffers except the current one" })

vim.keymap.set(
	"n",
	"<leader>cp",
	"<cmd>let @+ = expand('%')<CR>",
	{ noremap = true, silent = true, desc = "Copy the relative of the current file" }
)

vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover action: Show Type/Documentation" })

-- obsidian --
vim.keymap.set("n", "<leader>oo", "<cmd>Obsidian quick_switch<CR>", { desc = "Quick switch note" })
vim.keymap.set("n", "<leader>on", "<cmd>Obsidian new<CR>",          { desc = "New note" })
vim.keymap.set("n", "<leader>od", "<cmd>Obsidian today<CR>",        { desc = "Today's daily note" })
vim.keymap.set("n", "<leader>os", "<cmd>Obsidian search<CR>",       { desc = "Search notes" })
vim.keymap.set("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>",    { desc = "Show backlinks" })
vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian tags<CR>",         { desc = "Browse tags" })
vim.keymap.set("n", "<leader>ol", "<cmd>Obsidian links<CR>",        { desc = "Show links" })
