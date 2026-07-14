return {
  {
    "p00f/godbolt.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    cmd = { "Godbolt", "GodboltCompiler" },
    keys = {
      { "<leader>cx", "<cmd>Godbolt<cr>", desc = "Decompile Code (Godbolt)", mode = "n" },
      { "<leader>cx", "<cmd>'<,'>Godbolt<cr>", desc = "Decompile Code (Godbolt)", mode = "v" },

      { "<leader>cX", "<cmd>GodboltCompiler telescope<cr>", desc = "Decompile Code List (Godbolt)", mode = "n" },
      { "<leader>cX", "<cmd>'<,'>GodboltCompiler telescope<cr>", desc = "Decompile Code List (Godbolt)", mode = "v" },
    },
    config = function()
      require("godbolt").setup({
        languages = {
          c = { compiler = "rv64-cgcc1210", options = {} },
          rust = { compiler = "r1920", options = {} },
          ocaml = { compiler = "ocaml5200", options = {} },
        },
        highlight = {
          cursor = "Visual",
          static = false,
        },
      })
    end,
  },

  -- {
  --   "RaafatTurki/hex.nvim",
  --   cmd = { "HexDump", "HexAssemble", "HexToggle" },
  --   config = function()
  --     require("hex").setup({})
  --   end,
  -- },
}
