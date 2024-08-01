return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = 'markdown',

  dependencies = {
    'nvim-lua/plenary.nvim',
  },

  keys = {
    { '<leader>oc', '<cmd>ObsidianNew<cr>', desc = 'Obsidian Create' },
    { '<leader>oo', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Obsidian Open' },
    { '<leader>so', '<cmd>ObsidianSearch<cr>', desc = 'Search Obsidian' },
    { '<leader>ot', '<cmd>ObsidianToday<cr>', desc = 'Obsidian Today' },
  },

  opts = {
    workspaces = {
      {
        name = 'darkwood',
        path = '~/Documents/darkwood/notes',
      },
    },

    daily_notes = {
      folder = 'dailies',
      date_format = '%Y-%m-%d',
      default_tags = { 'daily-notes' },
    },

    disable_frontmatter = true,
    notes_subdir = '',
    new_notes_location = 'notes_subdir',

    note_id_func = function(title)
      return tostring(title:lower())
    end,
    -- note_id_func = function(title)
    --   -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    --   -- In this case a note with the title 'My new note' will be given an ID that looks
    --   -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
    --   local suffix = ''
    --   if title ~= nil then
    --     -- If title is given, transform it into valid file name.
    --     suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
    --   else
    --     -- If title is nil, just add 4 random uppercase letters to the suffix.
    --     for _ = 1, 4 do
    --       suffix = suffix .. string.char(math.random(65, 90))
    --     end
    --   end
    --   return tostring(os.time()) .. '-' .. suffix
    -- end,

    log_level = vim.log.levels.OFF,

    -- see below for full list of options 👇
    callbacks = {
      post_setup = function()
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
          pattern = { vim.fn.expand '~/Documents/' .. '**/*.md' },
          callback = function()
            vim.o.conceallevel = 2
          end,
        })
      end,
    },
  },
}
