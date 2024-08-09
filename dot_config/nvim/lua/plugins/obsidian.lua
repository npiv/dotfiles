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
    { '<leader>oc', '<cmd>ObsidianNew<cr>', desc = '[O]bsidian [C]reate' },
    { '<leader>oo', '<cmd>ObsidianQuickSwitch<cr>', desc = '[O]bsidian [O]pen' },
    { '<leader>fo', '<cmd>ObsidianSearch<cr>', desc = '[F]ind [O]bsidian' },
    { '<leader>ot', '<cmd>ObsidianToday<cr>', desc = '[O]bsidian [T]oday' },
    { '<leader>od', '<cmd>ObsidianDailies<cr>', desc = '[O]bsidian [D]ailies' },
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

    attachments = {
      img_folder = 'imgs',
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
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
        pattern = { vim.fn.expand '~/Documents/' .. '**/*.md' },
        callback = function()
          -- syntax match Hashtag /#\w\+/
          vim.cmd 'syntax match Hashtag /#\\w+/'
          vim.cmd 'highlight Hashtag ctermfg=Green guifg=pink guibg=darkgreen'

          -- vim.g.vim_markdown_frontmatter = 1
          vim.o.conceallevel = 2
          vim.cmd 'PencilSoft'
        end,
      }),
    },
  },
}
