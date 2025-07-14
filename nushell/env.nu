use std/util "path add"

# Add Cargo bin to PATH if directory exists
if ("~/.cargo/bin" | path expand | path exists) {
    path add "~/.cargo/bin"
}

# Add local bin to PATH if directory exists
if ("~/.local/bin" | path expand | path exists) {
    path add "~/.local/bin"
}

if ("~/.opam" | path expand | path exists) {
    opam env | lines | split column ';' vars | get vars | parse "{var}='{value}'" | transpose --header-row --as-record | load-env
}

$env.NUPM_HOME = ("~/.local/share" | path join "nupm")
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

# Set MANPAGER only if bat is installed
$env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"

# Carapace
if not ("~/.cache/carapace/init.nu" | path expand | path exists) {
    mkdir ~/.cache/carapace
    carapace _carapace nushell | save -f ~/.cache/carapace/init.nu
}

if not ("~/.local/share/atuin/init.nu" | path expand | path exists) {
    mkdir ~/.local/share/atuin
    atuin init nu | save -f ~/.local/share/atuin/init.nu
}

# Zoxide
if not ("~/.local/share/zoxide/zoxide.nu" | path expand | path exists) {
    mkdir ~/.local/share/zoxide
    zoxide init nushell --cmd cd | save -f ~/.local/share/zoxide/zoxide.nu
}
