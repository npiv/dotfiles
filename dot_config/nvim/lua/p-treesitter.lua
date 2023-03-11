require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "lua", "vim", "help", "typescript", "typescriptreact", "rust", "python" },

  sync_install = false,
  auto_install = true,
  ignore_install = {},

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
