return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dt", false },

      {
        "<leader>dS",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dr",
        function()
          require("dap").continue()
        end,
        desc = "Run with Args",
      },
    },
  },
}
