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
    -- ft = "markdown" -- If you decide to lazy-load anyway

    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },

    config = function()
      local markview = require 'markview'
      local presets = require 'markview.presets'

      -- local headings = presets.headings.glow

      local headings = {
        shift_width = 0,
        heading_1 = {
          hl = 'Markviewheading6',
          padding_left = '█',
          icon = ' ',
          style = 'label',
        },
        heading_2 = {
          hl = 'Markviewheading5',
          padding_left = '██',
          icon = ' ',
          style = 'label',
        },
        heading_3 = {
          hl = 'Markviewheading4',
          padding_left = '███',
          icon = ' ',
          style = 'label',
        },
        heading_4 = {
          hl = 'Markviewheading3',
          padding_left = '████',
          icon = ' ',
          style = 'label',
        },
        heading_5 = {
          hl = 'Markviewheading2',
          padding_left = '█████',
          icon = ' ',
          style = 'label',
        },
        heading_6 = {
          hl = 'Markviewheading1',
          padding_left = '██████',
          icon = ' ',
          style = 'label',
        },
      }

      markview.setup {
        inline_codes = {
          enable = false,
        },

        markdown = {
          headings = {
            enable = false,
          },
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
