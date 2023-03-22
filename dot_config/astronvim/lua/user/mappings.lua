return {
  n = {
    [";;"] = { "<cmd>e #<cr>", desc = "jump back to last file" },
    ["<leader>pp"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>p["] = {
      function()
        print("it works")
      end,
      desc = "Pick to close",
    }
  }
}
