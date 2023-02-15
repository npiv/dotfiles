require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    'lua_ls', "tsserver", "rust_analyzer"
  },
  automatic_installation = true,
})
