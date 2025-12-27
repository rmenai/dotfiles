return {
  {
    "mrjones2014/smart-splits.nvim",
    keys = {
      -- Resize panes
      { "<A-h>", function() require("smart-splits").resize_left() end, desc = "Resize pane left" },
      { "<A-j>", function() require("smart-splits").resize_down() end, desc = "Resize pane down" },
      { "<A-k>", function() require("smart-splits").resize_up() end, desc = "Resize pane up" },
      { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize pane right" },

      -- Swapping buffers
      { "<leader>wh", function() require("smart-splits").swap_buf_left() end, desc = "Swap buffer left" },
      { "<leader>wl", function() require("smart-splits").swap_buf_right() end, desc = "Swap buffer right" },
      { "<leader>wj", function() require("smart-splits").swap_buf_down() end, desc = "Swap buffer down" },
      { "<leader>wk", function() require("smart-splits").swap_buf_up() end, desc = "Swap buffer up" },
    },
    opts = {
      -- Disable in favor my my own custom navigation function
      multiplexer_integration = false,
    },
  },
}
