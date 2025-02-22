return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 15, -- Tamaño de la terminal (en modo horizontal)
			open_mapping = [[<C-0>]], -- Tecla para abrir/cerrar
			hide_numbers = true, -- Oculta los números de línea
			shade_terminals = true,
			start_in_insert = true, -- Inicia en modo INSERT
			insert_mappings = true, -- Permite <Esc> para salir de modo INSERT
			terminal_mappings = true, -- Habilita mapeos en terminal
			persist_size = true, -- Mantiene el tamaño
			direction = "float", -- Otras opciones: "horizontal", "vertical", "tab"
			close_on_exit = false, -- No cierra la terminal al salir
			shell = vim.o.shell, -- Usa la shell por defecto
		})
	end,
}
