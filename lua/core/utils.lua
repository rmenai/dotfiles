local function read_json(filepath)
    local file = io.open(filepath, "r")
    if not file then return nil end

    local content = file:read("*a")
    file:close()
    return vim.fn.json_decode(content)
end

local function slugify(title)
  local slug = title:lower()

  slug = slug:gsub("[^%w%s%-]", "")
  slug = slug:gsub("%s+", "-")
  slug = slug:gsub("-+", "-")
  return slug
end

return {
  read_json = read_json,
  slugify = slugify
}
