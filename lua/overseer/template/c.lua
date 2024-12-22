return {
  condition = {
    callback = function()
      if not vim.fn.executable("gcc") == 1 then return false, "Executable gcc not found" end
      if vim.fn.expand("%:e") ~= "c" then return false, "No c file found" end
      return true
    end,
  },
  generator = function(_, cb)
    local templates = {
      {
        name = "Run this program",
        builder = function()
          local file = vim.fn.expand("%:p")
          local executable = vim.fn.fnamemodify(file, ":r")
          executable = "out/" .. vim.fn.fnamemodify(executable, ":t")

          return {
            cmd = { "gcc", file, "-o", executable, "&&", executable },
          }
        end,
      },
    }

    cb(templates)
  end,
}
