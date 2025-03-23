return {
  'folke/zen-mode.nvim',
  config = function()
    local toggle_zen_mode = function(w, h, font)
      return function()
        require('zen-mode').toggle {
          window = {
            width = w,
            height = h,
            options = {
              number = false,
            },
          },
          plugins = {
            tmux = { enabled = true },
            gitsigns = { enabled = true },
            alacritty = {
              enabled = true,
              font = font,
            },
            wezterm = {
              enabled = true,
              font = '+2',
            },
          },
          on_open = function(win) end,
          on_close = function() end,
        }
      end
    end

    vim.keymap.set('n', '<leader>zo', toggle_zen_mode(0.7, 0.9, 20), { desc = '[Z]en [O]pen' })
    vim.keymap.set('n', '<leader>zb', toggle_zen_mode(0.55, 0.9, 16), { desc = '[Z]en [B]ig' })
    vim.keymap.set('n', '<leader>zs', toggle_zen_mode(0.9, 0.9, 16), { desc = '[Z]en [S]mall' })
    vim.keymap.set('n', '<leader>zp', '<cmd>Pencil<cr>', { desc = '[Z]en [P]encil' })
  end,
}
