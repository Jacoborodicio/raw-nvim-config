return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    default = {
      -- Save images to an "attachments" folder (Obsidian convention)
      dir_path = "attachments",

      -- Use the Obsidian-style wiki image embed
      -- Change to "![$CURSOR]($FILE_PATH)" if you prefer standard markdown
      template = "![[attachments/$FILE_NAME]]",

      -- Prompt for a filename when pasting
      prompt_for_file_name = true,

      -- Drag and drop support (in normal mode)
      drag_and_drop = {
        enabled = true,
      },
    },
  },
  keys = {
    { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
  },
}
