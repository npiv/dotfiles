return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },
  {
    'OXY2DEV/markview.nvim',
    enabled = true,
    lazy = false, -- Recommended

    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },

    config = function()
      local markview = require 'markview'
      local presets = require 'markview.presets'

      markview.setup {
        inline_codes = {
          enable = false,
        },

        markdown = {
          headings = presets.headings.glow,
          -- headings = {
          --    enable = true,
          -- },
          list_items = {
            indent_size = 1,
            shift_width = 2,
          },
        },

        links = {
          enable = true,
        },
      }
    end,
  },
}
