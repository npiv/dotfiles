return {
  colorscheme = "catppuccin-frappe",
  plugins = {
    {
      "zbirenbaum/copilot.lua",
      as = "copilot",
      cmd = "Copilot",
      event = "User Astrofile",
      opts = { suggestion = { auto_trigger = true, debounce = 150 } },
      config = function()
        require("copilot").setup({
          panel = {
            auto_refresh = false,
            keymap = {
              accept = "<CR>",
              jump_prev = "[[",
              jump_next = "]]",
              refresh = "gr",
              open = "<M-CR>",
            },
          },
          suggestion = {
            auto_trigger = true,
            keymap = {
              accept = "<M-l>",
              prev = "<M-[>",
              next = "<M-]>",
              dismiss = "<C-]>",
            },
          },
        })
      end,
    },
    {
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
        require("catppuccin").setup {}
      end,
    },
  },
}
