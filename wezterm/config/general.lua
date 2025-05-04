local fs = require("utils.fn").fs
local Config = {}

Config.default_cwd = fs.home()
Config.unix_domains = {}
Config.ssh_domains = {
  {
    name = "kali",
    remote_address = "10.10.10.10",
    username = "vault",
    multiplexing = "WezTerm",
  },
}

return Config
