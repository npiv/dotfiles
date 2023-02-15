vim.g.everforest_diagnostic_line_highlight = 1
vim.g.everforest_background = 'hard'
vim.cmd('colorscheme everforest')

vim.fn.sign_define({
  {
    name = 'DiagnosticSignError',
    text = 'E',
    texthl = 'DiagnosticSignError',
    linehl = 'ErrorLine'
  },
  {
    name = 'DiagnosticSignWarn',
    text = 'W',
    texthl = 'DiagnosticSignWarn',
    linehl = 'WarnLine'
  },
  {
    name = 'DiagnosticSignInfo',
    text = 'I',
    texthl = 'DiagnosticSignInfo',
    linehl = 'InfoLine'
  },
  {
    name = 'DiagnosticSignHint',
    text = 'H',
    texthl = 'DiagnosticSignHint',
    linehl = 'HintLine'
  },
})
