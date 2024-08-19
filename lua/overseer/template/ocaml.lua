local function get_ocaml_executable()
  local executables = { "ocaml" }

  for _, executable in ipairs(executables) do
    if vim.fn.executable(executable) == 1 then
      return executable
    end
  end
end

return {
  condition = {
    callback = function()
      if not get_ocaml_executable() then
        return false, "Executable ocaml not found"
      end
      if vim.fn.expand("%:e") ~= "ml" then
        return false, "No OCaml file found"
      end
      return true
    end,
  },
  generator = function(_, cb)
    local executable = get_ocaml_executable()
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
        name = "Start OCaml REPL",
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
