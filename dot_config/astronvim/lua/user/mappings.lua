return {
  n = {
    ["<leader>pp"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>p["] = {
      function()
        print("it works")
      end,
      desc = "Pick to close",
    }
  }
}
