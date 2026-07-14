return {
  name = "C Tasks",
  condition = {
    filetype = { "c" },
  },
  generator = function(_, cb)
    local file = vim.fn.expand("%:p")
    local filename_no_ext = vim.fn.fnamemodify(file, ":t:r")

    local out_dir = "out"
    local output_bin = out_dir .. "/" .. filename_no_ext

    local templates = {
      {
        name = "Interpret File (C)",
        builder = function()
          local temp_bin = "./" .. filename_no_ext .. "_temp"
          local command = string.format("gcc '%s' -o '%s' && '%s' && rm '%s'", file, temp_bin, temp_bin, temp_bin)
          return {
            cmd = { "bash", "-c", command },
            components = { "default" },
          }
        end,
      },

      {
        name = "Compile File (C)",
        builder = function()
          local command = string.format("mkdir -p %s && gcc '%s' -o '%s'", out_dir, file, output_bin)
          return {
            cmd = { "bash", "-c", command },
            components = { "default" },
          }
        end,
      },

      {
        name = "Run Compiled File (C)",
        builder = function()
          local command = string.format("[ -f '%s' ] && '%s' || echo 'Executable not found in %s/. Compile first.'", output_bin, output_bin, out_dir)
          return {
            cmd = { "bash", "-c", command },
            components = { "default" },
          }
        end,
      },
    }

    cb(templates)
  end,
}
