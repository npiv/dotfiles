local vcmd = vim.cmd

-- vcmd 'setlocal spell spelllang=en_us'
vcmd 'setlocal expandtab shiftwidth=4 softtabstop=4 autoindent'

-- Setup cmp setup buffer configuration - 👻 text off for markdown
local cmp = require 'cmp'
cmp.setup.buffer {
  sources = {
    { name = 'vsnip' },
    { name = 'spell' },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
    },
    { name = 'path' },
  },
  experimental = {
    ghost_text = false,
  },
}

vcmd 'set conceallevel=2'
