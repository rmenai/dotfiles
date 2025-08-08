# Nushell Configuration
# This file contains the core configuration for Nushell

# Load custom aliases and functions
source ~/.config/nushell/aliases.nu
source ~/.config/nushell/functions.nu

# Completion configuration
let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        _ => $carapace_completer
    } | do $in $spans
}

# Main configuration
$env.config = {
    edit_mode: "vi"
    show_banner: false
    float_precision: 4

    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"

        external: {
            enable: true
            completer: $external_completer
        }
    }

    hooks: {
        env_change: {
            PWD: []
        }
    }
}

# Cursor configuration
$env.config.cursor_shape = {
    emacs: line
    vi_insert: line
    vi_normal: block
}

# Command not found hook
$env.config.hooks.command_not_found = { |cmd_name|
  if (which comma | is-not-empty) {
    comma -a $cmd_name
    print ""
    null
  }
}

# PWD change hook (direnv integration)
$env.config.hooks.env_change.PWD = (
    $env.config.hooks.env_change.PWD | append (source nu_scripts/nu-hooks/nu-hooks/direnv/config.nu)
)

# Starship prompt initialization
let starship_config_path = ($nu.data-dir | path join "vendor/autoload/starship.nu")
if not ($starship_config_path | path exists) {
    mkdir ($starship_config_path | path dirname)
    starship init nu | save -f $starship_config_path
}

# Third-party modules and scripts
source nu_scripts/aliases/git/git-aliases.nu
source nu_scripts/aliases/bat/bat-aliases.nu

source nu_scripts/themes/nu-themes/catppuccin-mocha.nu
source nu_scripts/nu-hooks/nu-hooks/rusty-paths/rusty-paths.nu

source nu_scripts/modules/nix/nix.nu
source nu_scripts/modules/nix/nufetch.nu

source nu_scripts/modules/system/mod.nu
source nu_scripts/modules/network/ssh.nu
source nu_scripts/modules/network/sockets/sockets.nu

source nu_scripts/modules/jc/mod.nu
source nu_scripts/modules/git/git.nu

source nu_scripts/modules/formats/from-cpuinfo.nu
source nu_scripts/modules/formats/from-dmidecode.nu
source nu_scripts/modules/formats/from-env.nu

source nu_scripts/modules/fnm/fnm.nu
source nu_scripts/modules/docker/mod.nu

# External tool integrations
source ~/.cache/carapace/init.nu
source ~/.local/share/zoxide/zoxide.nu
source ~/.local/share/atuin/init.nu
