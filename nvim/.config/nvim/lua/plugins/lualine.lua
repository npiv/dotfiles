return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'catppuccin/nvim',
  },
  config = function()
    require('lualine').setup {
      options = {
        -- catppuccin dropped the old "catppuccin" theme name
        theme = 'catppuccin-nvim',
      },
    }
  end,
}
