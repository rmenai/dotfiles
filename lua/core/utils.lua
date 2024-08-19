local M = {}

M.get_cmakefile = function()
	local cwd = vim.fn.getcwd()
	return vim.fs.find("CMakeLists.txt", { upward = true, type = "file", path = cwd })[1]
end

M.read_json = function(filepath)
	local file = io.open(filepath, "r")
	if not file then
		return nil
	end

	local content = file:read("*a")
	file:close()
	return vim.fn.json_decode(content)
end

M.slugify = function(title)
	local slug = title:lower()

	slug = slug:gsub("[^%w%s%-]", "")
	slug = slug:gsub("%s+", "-")
	slug = slug:gsub("-+", "-")
	return slug
end

return M
