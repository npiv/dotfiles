return {
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   opts = {
  --     keymaps = {
  --       accept_suggestion = "<C-]>",
  --
  --     },
  --   },
  --   config = function()
  --     require("supermaven-nvim").setup({
  --       keymaps = {
  --         accept_suggestion = "<C-]>",
  --         clear_word = "<C-[>",
  --       },
  --       color = {
  --         suggestion_color = "tomato",
  --       },
  --     })
  --   end,
  -- },

  {
    "nvim-cmp",
    dependencies = {
      "supermaven-inc/supermaven-nvim",
      opts = {},
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "supermaven",
        group_index = 1,
        priority = 100,
      })
    end,
  },
}
