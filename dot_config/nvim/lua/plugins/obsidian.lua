return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = 'markdown',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'preservim/vim-pencil',
  },

  keys = {
    { '<leader>oc', '<cmd>ObsidianNew<cr>', desc = 'Obsidian Create' },
    { '<leader>oo', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Obsidian Open' },
    { '<leader>fo', '<cmd>ObsidianSearch<cr>', desc = '[F]ind [O]bsidian' },
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

    ui = { enable = false },

    disable_frontmatter = true,
    notes_subdir = '',
    new_notes_location = 'notes_subdir',

    note_id_func = function(title)
      return tostring(title:lower())
    end,

    log_level = vim.log.levels.OFF,

    callbacks = {
      post_setup = function()
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
          pattern = { vim.fn.expand '~/Documents/' .. '**/*.md' },
          callback = function()
            -- vim.g.vim_markdown_frontmatter = 1
            vim.o.conceallevel = 2
            -- vim.cmd 'PencilSoft'
          end,
        })
      end,
    },
  },
}
