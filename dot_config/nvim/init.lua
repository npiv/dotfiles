require('base')
if vim.g.vscode then

else
  require('base')
  require('maps')
  require('plugins')
  require('p-mason')
  require('p-lsp')
  require('p-ftree')
  require('color')
  require('p-telescope')
  require('p-cmp')
  require('p-leap')
  require('p-null')
end
