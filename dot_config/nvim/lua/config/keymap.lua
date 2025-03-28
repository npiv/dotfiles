vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- navigate quicklist
vim.keymap.set('n', '<leader>]', '<cmd>cnext<CR>')
vim.keymap.set('n', '<leader>[', '<cmd>cprev<CR>')

-- jump back to last file
vim.keymap.set({ 'n', 'v', 'i' }, ';;', '<C-^>', { noremap = true, silent = true })

-- Keybinds to make split navigation easier.
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--
vim.keymap.set('n', '<leader>ss', '<cmd>set spell<CR>')

-- move lines up and down
vim.keymap.set('v', '<up>', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('v', '<down>', ":m '>+1<CR>gv=gv", { silent = true })

vim.keymap.set('n', '<leader>ya', 'ggyG')
