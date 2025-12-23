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
  name = "OCaml Tasks",
  condition = {
    filetype = { "ocaml" },
  },
  generator = function(_, cb)
    local project_name = get_project_name() or "./bin/main.exe" -- Default to main.exe if name not found

    local templates = {
      {
        name = "Interpret File (OCaml)",
        builder = function()
          return {
            cmd = { "ocaml" },
            args = { vim.fn.expand("%:p") },
            components = { "default" },
          }
        end,
      },

      {
        name = "Run Project (OCaml)",
        builder = function()
          return {
            -- Using shell to chain build && exec
            cmd = { "bash", "-c", string.format("dune build && dune exec %s", project_name) },
            components = { "default" },
          }
        end,
      },
    }

    cb(templates)
  end,
}
