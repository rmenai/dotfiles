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

# Custom functions
# A way to load ocaml env
def --env opam-env [] {
    opam env --shell=powershell
    | parse "$env:{key} = '{val}'"
    | transpose -rd
    | load-env
}
