require 'config.options'
require 'config.keymap'
require 'config.autocmds'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

local opts = {
  change_detection = {
    notify = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
}

require('lazy').setup('plugins', opts)

-- hack couldnt escape this via vim.run
vim.cmd('source ' .. vim.fn.expand '~' .. '/.config/nvim/vim/highlight_tags.vim')
