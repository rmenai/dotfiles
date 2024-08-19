return {
	{
		-- AUTO CWD
		"ahmedkhalf/project.nvim",
		event = "BufRead",
		config = function()
			require("project_nvim").setup({
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "main.py" },
			})
		end,
	},
}
