return {
  colorscheme = "catppuccin-frappe",
  plugins = {
    {
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
        require("catppuccin").setup {}
      end,
    },
  },
}
