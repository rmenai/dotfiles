return {
  {
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify",
    opts = {
      slots = { "a", "b", "c" },

      mapping = {
        startStopRecording = "q",
        playMacro = "Q",
        switchSlot = "<C-q>",
        editMacro = "cq",
        deleteAllMacros = "dq",
        yankMacro = "yq",
        addBreakPoint = "##",
      },
    },
  },
}
