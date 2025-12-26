## Nushell Configuration
## This file contains the core configuration for Nushell

# Main configuration
$env.config = {
    edit_mode: "vi"
    show_banner: false

    cursor_shape: {
      vi_insert: line
      vi_normal: block
    }

    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"

        external: {
            enable: true
            max_results: 100
        }
    }
}

# Load custom aliases and functions
source ~/.config/nushell/aliases.nu
source ~/.config/nushell/functions.nu

# Source external tools
source $"($nu.cache-dir)/carapace.nu"
source ~/.local/share/atuin/init.nu
# source ~/.local/share/zoxide/zoxide.nu

source ./external/command-not-found.nu
source ./external/catppuccin.nu
source ./external/starship.nu
source ./external/direnv.nu
