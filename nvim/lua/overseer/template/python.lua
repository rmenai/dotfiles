return {
  name = "Python Tasks",
  condition = {
    filetype = { "python" },
  },
  generator = function(_, cb)
    local file = vim.fn.expand("%:p")

    local templates = {
      {
        name = "Interpret File (Python)",
        builder = function()
          return {
            cmd = { "python" },
            args = { file },
            components = { "default" },
          }
        end,
      },
    }

    cb(templates)
  end,
}
