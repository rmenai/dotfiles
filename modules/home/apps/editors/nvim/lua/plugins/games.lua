return {
  {
    "NStefan002/speedtyper.nvim",
    cmd = "Speedtyper",
    config = function()
      require("speedtyper").setup({})
    end,
  },
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
    config = false,
  },
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    config = false,
  },
  {
    "jim-fx/sudoku.nvim",
    cmd = "Sudoku",
    config = function()
      require("sudoku").setup({})
    end,
  },
}
