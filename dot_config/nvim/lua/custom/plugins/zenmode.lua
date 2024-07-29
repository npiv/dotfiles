return {
  'folke/zen-mode.nvim',
  config = function()
    local toggle_markdown = function()
      require('zen-mode').toggle {
        window = {
          width = 0.6, -- width will be 85% of the editor width
          options = {
            number = false,
          },
        },
        plugins = {
          tmux = { enabled = true },
          gitsigns = { enabled = true },
          twilight = { enabled = false },
          wezterm = {
            enabled = true,
            -- can be either an absolute font size or the number of incremental steps
            font = '22', -- (10% increase per step)
          },
        },
        on_open = function(win)
          vim.g.vim_markdown_frontmatter = 1
          vim.o.linebreak = true
          vim.o.conceallevel = 2
        end,
        -- callback where you can add custom code when the Zen window closes
        on_close = function() end,
      }
    end

    local toggle_default = function()
      require('zen-mode').toggle {
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
        on_open = function(win) end,
        -- callback where you can add custom code when the Zen window closes
        on_close = function() end,
      }
    end
    vim.keymap.set('n', 'zo', toggle_markdown)
    vim.keymap.set('n', 'zm', toggle_default)
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
