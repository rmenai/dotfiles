local function get_python_executable()
  local executables = { "python3", "python" }

  for _, executable in ipairs(executables) do
    if vim.fn.executable(executable) == 1 then
      return executable
    end
  end
end

return {
  condition = {
    callback = function()
      if not get_python_executable() then
        return false, "Executable python not found"
      end
      if vim.fn.expand("%:e") ~= "py" then
        return false, "No python file found"
      end
      return true
    end,
  },
  generator = function(_, cb)
    local executable = get_python_executable()
    local templates = {
      {
        name = "Run this program",
        builder = function()
          local file = vim.fn.expand("%:p")
          return {
            cmd = { executable },
            args = { file },
          }
        end,
      },
      {
        name = "Start python REPL",
        builder = function()
          return {
            cmd = { executable },
          }
        end,
      },
    }

    cb(templates)
  end,
}
