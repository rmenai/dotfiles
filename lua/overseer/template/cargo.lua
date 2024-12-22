local function get_cargo_file(opts)
  return vim.fs.find("Cargo.toml", { upward = true, type = "file", path = opts.dir })[1]
end

return {
  condition = {
    callback = function(opts)
      if vim.fn.executable("cargo") ~= 1 then
        return false, "Executable cargo not found"
      end
      if not get_cargo_file(opts) then
        return false, "No Cargo.toml file found"
      end
      return true
    end,
  },
  generator = function(_, cb)
    local templates = {
      {
        name = "cargo watch",
        builder = function()
          return {
            cmd = { "cargo", "watch", "-q", "-c", "-w", "src/", "-x", "'run -q'" },
          }
        end,
      },
    }

    cb(templates)
  end,
}
