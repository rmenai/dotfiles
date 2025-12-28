local wt = require("wezterm")
local Config = {}

Config.unix_domains = {}
Config.ssh_domains = wt.default_ssh_domains()

for _, dom in ipairs(Config.ssh_domains) do
  dom.assume_shell = "Posix"
end

return Config
