return {
  'MeanderingProgrammer/markdown.nvim',
  enabled = false,
  dependencies = {
    'preservim/vim-pencil',
  },
  config = function()
    require('render-markdown').setup {
      heading = {
        sign = false,
        icons = { '# ', '## ', '### ', '#### ', '##### ', '###### ' },
      },
    }
  end,
}
