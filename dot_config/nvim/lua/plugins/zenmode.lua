return {
  'folke/zen-mode.nvim',
  config = function()
    local toggle_markdown = function()
      require('zen-mode').toggle {
        window = {
          width = 0.7, -- width will be 85% of the editor width
          height = 0.9,
          options = {
            number = false,
          },
        },
        plugins = {
          tmux = { enabled = true },
          gitsigns = { enabled = true },
          wezterm = {
            enabled = true,
            -- can be either an absolute font size or the number of incremental steps
            font = '22', -- (10% increase per step)
          },
          alacritty = {
            enabled = true,
            font = '20',
          },
        },
        on_open = function(win)
          vim.g.vim_markdown_frontmatter = 1
          vim.cmd 'Pencil'
        end,
        -- callback where you can add custom code when the Zen window closes
        on_close = function()
          vim.cmd 'PencilOff'
        end,
      }
    end

    local toggle_default = function()
      require('zen-mode').toggle {
        plugins = {
          tmux = { enabled = true },
          gitsigns = { enabled = true },
          wezterm = {
            enabled = true,
            -- can be either an absolute font size or the number of incremental steps
            font = '+1', -- (10% increase per step)
          },
          alacritty = {
            enabled = true,
            font = '18',
          },
        },
        on_open = function(win) end,
        -- callback where you can add custom code when the Zen window closes
        on_close = function() end,
      }
    end
    vim.keymap.set('n', 'zo', toggle_markdown, { desc = 'Zen Obsidian' })
    vim.keymap.set('n', 'zm', toggle_default, { desc = 'Zen Mode' })
  end,

  opts = {
    window = {
      width = 0.75,
    },
    plugins = {
      tmux = { enabled = true },
      gitsigns = { enabled = true },
      twilight = { enabled = false },
      wezterm = {
        enabled = true,
        -- can be either an absolute font size or the number of incremental steps
        font = '+1', -- (10% increase per step)
      },
    },
  },
}