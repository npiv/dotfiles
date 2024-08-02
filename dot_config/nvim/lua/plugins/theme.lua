return {
  {
    'catppuccin/nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require('catppuccin').setup {
        flavour = 'macchiato',
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
