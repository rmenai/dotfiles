return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "folke/snacks.nvim",
    },
    cmd = "Neogit",
    keys = {
      {
        "<leader>gg",
        function()
          local neogit = require("neogit")

          -- Check if NeogitStatus is open in any window
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "NeogitStatus" then
              neogit.close() -- Close if found
              return
            end
          end

          -- Otherwise open
          neogit.open({ kind = "auto" })
        end,
        desc = "Toggle Neogit",
      },
    },
  },
}
