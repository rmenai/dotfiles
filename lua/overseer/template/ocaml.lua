local function get_ocaml_executable()
  local executables = { "ocaml" }

  for _, executable in ipairs(executables) do
    if vim.fn.executable(executable) == 1 then return executable end
  end
end

local cached_project_names = {}

local function get_project_name()
  local cwd = vim.fn.getcwd()
  if cached_project_names[cwd] then return cached_project_names[cwd] end

  local dune_file = "bin/dune"
  local file = io.open(dune_file, "r")
  if not file then return nil end

  for line in file:lines() do
    local name = line:match("%(%s*public_name%s+([%w_%-]+)%s*%)")
    if name then
      file:close()
      cached_project_names[cwd] = name
      return name
    end
  end

  file:close()
  return nil
end

return {
  condition = {
    callback = function()
      if not get_ocaml_executable() then return false, "Executable ocaml not found" end
      if vim.fn.expand("%:e") ~= "ml" then return false, "No OCaml file found" end
      return true
    end,
  },
  generator = function(_, cb)
    local executable = get_ocaml_executable()
    local project_name = get_project_name() or "./bin/main.bc"
    local templates = {
      {
        name = "Interpret this program",
        builder = function()
          local file = vim.fn.expand("%:p")
          return {
            cmd = { executable },
            args = { file },
          }
        end,
      },
      {
        name = "Run this program",
        builder = function()
          return {
            cmd = { "dune", "build", "&&", "dune", "exec", project_name },
          }
        end,
      },
      {
        name = "Start OCaml REPL",
        builder = function()
          return {
            cmd = { "utop" },
          }
        end,
      },
    }

    cb(templates)
  end,
}
