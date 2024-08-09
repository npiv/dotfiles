return {
  'OXY2DEV/markview.nvim',
  lazy = false, -- Recommended
  -- ft = "markdown" -- If you decide to lazy-load anyway

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local markview = require 'markview'
    local presets = require 'markview.presets'

    local headings = presets.headings.glow
    headings.shift_width = 1

    markview.setup {
      headings = headings,
      links = {
        enable = true,
      },
    }
  end,
}
