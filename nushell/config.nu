# NixOS aliases
def "nix-shell" [...rest] { ^nix-shell --run zsh ...$rest }
def "nrs" [] { sudo nixos-rebuild switch --flake $"($env.HOME)/.config/nixos#(hostname)" }
def "nrb" [] { sudo nixos-rebuild boot --flake $"($env.HOME)/.config/nixos#(hostname)" }
def "nrt" [] { sudo nixos-rebuild test --flake $"($env.HOME)/.config/nixos#(hostname)" }

def "hrs" [] { home-manager switch --flake $"($env.HOME)/.config/nixos#vault@(hostname)" }
def "hrb" [] { home-manager build --flake $"($env.HOME)/.config/nixos#vault@(hostname)" }

alias hibernate = systemctl hibernate
alias rm = rm -I

# Standard ls aliases
alias ll = ls -l
alias la = ls -a

alias cat = bat

# fzf and bat dependent alias
alias fzfp = fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"

# xclip dependent aliases
alias c = clipboard copy
alias p = clipboard paste

# nvim dependent aliases
alias v = nvim
alias vimdiff = nvim -d

# tmux dependent aliases
alias t = tmux
alias ta = tmux attach
alias tad = tmux attach -d -t
alias tkss = tmux kill-session -t
alias tksv = tmux kill-server
alias tl = tmux list-sessions
alias ts = tmux new-session -s

alias a = atuin
alias ast = atuin stats
alias asr = atuin scripts run
alias asn = atuin scripts new
alias asd = atuin scripts delete
alias asl = atuin scripts list

# gh dependent aliases
alias "?" = gh copilot suggest
alias "??" = gh copilot explain

# Yazi function
def y [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file=$tmp
    let cwd = (open $tmp | str trim)
    if ($cwd != "" and $cwd != $env.PWD) {
        cd $cwd
    }
    rm -f $tmp
}

# Sesh function
def s [] {
    let session = (sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    if ($session | str length) > 0 {
        sesh connect $session
    }
}

# Wezterm nvim function
def wtnvim [file: string] {
    if ($file | str length) == 0 {
        print "Usage: wtnvim <file>"
        return
    }

    let dir = ($file | path dirname)
    let realfile = ($file | path expand)

    wezterm cli spawn -- zsh -l -i -c $"cd \"($dir)\" && nvim \"($realfile)\"; exec zsh"
}

def "notify on done" [
    task: closure
] {
    let start = date now
    let result = do $task
    let end = date now
    let total = $end - $start | format duration sec
    let body = $"Task completed in ($total)"
    notify -s "Task Finished" -t $body
    return $result
}

let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion

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

$env.config.cursor_shape = {
    emacs: line
    vi_insert: line
    vi_normal: block
}

$env.config.hooks.command_not_found = { |command_name|
    print (command-not-found $command_name | str trim)
}

$env.config.hooks.env_change.PWD = (
    $env.config.hooks.env_change.PWD | append (source nu_scripts/nu-hooks/nu-hooks/direnv/config.nu)
)

let starship_config_path = ($nu.data-dir | path join "vendor/autoload/starship.nu")
if not ($starship_config_path | path exists) {
    mkdir ($starship_config_path | path dirname)
    starship init nu | save -f $starship_config_path
}


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

source ~/.cache/carapace/init.nu
source ~/.local/share/zoxide/zoxide.nu
source ~/.local/share/atuin/init.nu
