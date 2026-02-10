return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",           -- use latest release for stability
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Optional but recommended:
    -- "hrsh7th/nvim-cmp",           -- for completion (classic)
    -- "saghen/blink.cmp",           -- for completion (modern alternative)
    -- "nvim-telescope/telescope.nvim", -- for picker/search
    -- "ibhagwan/fzf-lua",           -- alternative picker
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,  -- use new :Obsidian <subcommand> format

    workspaces = {
      {
        name = "2026",
        path = "~/Documents/2026"
      },
      -- Add more workspaces if needed:
      -- { name = "work", path = "~/work-vault" },
    },

    -- Daily notes config
    daily_notes = {
      folder = "daily",            -- subfolder for daily notes
      date_format = "%Y-%m-%d",    -- e.g. 2026-02-10
      template = nil,              -- optional template file name
    },

    -- How new note IDs are generated
    note_id_func = function(title)
      -- Use the title as the filename (slugified) instead of random IDs
      if title ~= nil then
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If no title, generate a 4-char random id
        local suffix = ""
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
        return tostring(os.time()) .. "-" .. suffix
      end
    end,

    -- Where to put new notes
    new_notes_location = "current_dir",

    -- Templates
    templates = {
      folder = "templates",
    },

    -- Completion (auto-triggers on [[ for links, # for tags)
    completion = {
      nvim_cmp = true,     -- set to false if using blink.cmp
      min_chars = 2,
    },
  },
}
