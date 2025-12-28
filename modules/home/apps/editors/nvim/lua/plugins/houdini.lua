return {
  {
    -- BETTER ESCAPE INSERT
    "TheBlob42/houdini.nvim",
    event = "ModeChanged",
    opts = {
      mappings = { "jj", "jk" },
      timeout = 200,
      escape_sequences = {
        ["v"] = false,
        ["vs"] = false,
        ["V"] = false,
        ["Vs"] = false,
        ["no"] = false,
        ["nov"] = false,
        ["noV"] = false,
      },
    },
  },
}
