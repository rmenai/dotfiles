use std/util "path add"

# Add Cargo bin to PATH if directory exists
if ("~/.cargo/bin" | path expand | path exists) {
    path add "~/.cargo/bin"
}

# Add local bin to PATH if directory exists
if ("~/.local/bin" | path expand | path exists) {
    path add "~/.local/bin"
}

$env.NUPM_HOME = ($env.XDG_DATA_HOME | path join "nupm")
$env.NU_LIB_DIRS = [
    ...
    ($env.NUPM_HOME | path join "modules")
]
$env.PATH = (
    $env.PATH
        | split row (char esep)
        | prepend ($env.NUPM_HOME | path join "scripts")
        | uniq
)

# Editor configuration
$env.EDITOR = "nvim"; $env.SUDO_EDITOR = "nvim"

# History configuration
$env.HISTORY_BASE = ($nu.data-dir | path join "history")

# Set MANPAGER only if bat is installed
$env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"

# Carapace
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

# Zoxide
if not ("~/.local/share/zoxide/zoxide.nu" | path expand | path exists) {
    zoxide init nushell --cmd cd | save -f ~/.local/share/zoxide/zoxide.nu
}

opam env | lines | split column ';' vars | get vars | parse "{var}='{value}'" | transpose --header-row --as-record | load-env
