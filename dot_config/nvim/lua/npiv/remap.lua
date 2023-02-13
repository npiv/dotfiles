vim.g.mapleader = ";"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- yank to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- jump to previous buffer and back
vim.keymap.set('n', '<leader><leader>', ':e #<CR>')

vim.keymap.set('n', '<leader>cv', ':cd ~/.config/nvim<CR>:Ex ~/.config/nvim<CR>')
