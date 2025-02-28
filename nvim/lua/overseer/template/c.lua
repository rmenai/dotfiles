return {
  condition = {
    callback = function()
      if vim.fn.executable("gcc") ~= 1 then return false, "Executable gcc not found" end
      if vim.fn.expand("%:e") ~= "c" then return false, "No C file found" end
      return true
    end,
  },
  generator = function(_, cb)
    local templates = {
      {
        name = "Interpret this program",
        builder = function()
          local file = vim.fn.expand("%:p")
          local executable = vim.fn.fnamemodify(file, ":r")
          local command = string.format("gcc %s -o %s && %s && rm %s", file, executable, executable, executable)
          return {
            cmd = { "bash", "-c", command },
          }
        end,
      },
      {
        name = "Compile this program",
        builder = function()
          local file = vim.fn.expand("%:p")
          local executable = vim.fn.fnamemodify(file, ":r")
          executable = "out/" .. vim.fn.fnamemodify(executable, ":t")
          local command = string.format("mkdir -p out && gcc %s -o %s", file, executable)
          return {
            cmd = { "bash", "-c", command },
          }
        end,
      },
      {
        name = "Run this program",
        builder = function()
          local file = vim.fn.expand("%:p")
          local executable = "out/" .. vim.fn.fnamemodify(file, ":t:r")
          local command = string.format("[ -f %s ] && %s || echo 'Executable not found. Compile first.'", executable, executable)
          return {
            cmd = { "bash", "-c", command },
          }
        end,
      },
    }
    cb(templates)
  end,
}
