local Config = {}

Config.unix_domains = {}
Config.ssh_domains = {
  {
    name = "kali",
    remote_address = "10.10.10.10",
    username = "vault",
    multiplexing = "WezTerm",
  },
  {
    name = "flare",
    remote_address = "10.10.10.8",
    username = "vault",
    multiplexing = "WezTerm",
  },
}

return Config
