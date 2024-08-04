return {
  'MeanderingProgrammer/markdown.nvim',
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
