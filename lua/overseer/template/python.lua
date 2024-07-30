local function find_virtualenv_python()
  local venv_dirs = { ".venv", "venv", "env" }
  local python_path = "/bin/python"
  local cwd = vim.fn.getcwd()

  for _, venv_dir in ipairs(venv_dirs) do
    local venv_python_path = cwd .. "/" .. venv_dir .. python_path
    if vim.fn.executable(venv_python_path) == 1 then
      return venv_python_path
    end
  end
end

local function find_system_python()
  local executables = { "python3", "python" }

  for _, executable in ipairs(executables) do
    if vim.fn.executable(executable) == 1 then
      return executable
    end
  end
end

local function get_python_executable()
  local python_executable = find_virtualenv_python()

  if python_executable then
    return python_executable
  else
    local system_python = find_system_python()
    if system_python then
      return system_python
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
    end
  },
  generator = function(opts, cb)
    local executable = get_python_executable()
    local templates = {
      {
        name = "Run this program",
        builder = function()
          local file = vim.fn.expand("%:p")
          return {
            cmd = { executable },
            args = { file }
          }
        end
      },
      {
        name = "Start python REPL",
        builder = function()
          return {
            cmd = { executable }
          }
        end
      }
    }

    cb(templates)
  end
}
