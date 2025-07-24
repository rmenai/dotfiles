# Enhanced help command with filtering options
def h [
    --aliases (-a) # Show aliases only
    --custom (-c) # Show custom functions only
    --plugin (-p) # Show plugin functions only
    --builtin (-b) # Show builtin functions only
    --all # Show everything (aliases, custom, plugin, and builtin functions)
] {
    # Display help information with various filtering options
    mut result = []

    # Show aliases if requested
    if $aliases or $all {
        $result = ($result | append (help aliases | insert length {|row| $row.name | str length} | sort-by length | reverse | select name expansion))
    }

    # Show custom functions if requested
    if $custom or $all {
        $result = ($result | append (help commands | where command_type == "custom" | insert length {|row| $row.name |
        str length} | sort-by length | reverse))
    }

    # Show plugin functions if requested
    if $plugin or $all {
        $result = ($result | append (help commands | where command_type == "plugin" | insert length {|row| $row.name |
        str length} | sort-by length | reverse))
    }

    # Show builtin functions if requested
    if $builtin or $all {
        $result = ($result | append (help commands | where command_type == "built-in" | insert length {|row| $row.name |
        str length} | sort-by length | reverse))
    }

    $result
}

# Yazi file manager with directory change
def --env y [
    ...args # Arguments to pass to yazi
] {
    # Launch yazi file manager and change to selected directory
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != "" and $cwd != $env.PWD {
        cd $cwd
    }
    rm -fp $tmp
}

# Sesh tmux session manager
def s [
] {
    # Interactive tmux session selector using sesh and fzf
    let session = (sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    if ($session | str length) > 0 {
        sesh connect $session
    }
}

# WezTerm nvim launcher
def wtnvim [
    file: string # File path to open in nvim within a new WezTerm pane
] {
    # Open a file in nvim within a new WezTerm pane
    if ($file | str length) == 0 {
        print "Usage: wtnvim <file>"
        return
    }

    let dir = ($file | path dirname)
    let realfile = ($file | path expand)

    wezterm cli spawn -- zsh -l -i -c $"cd \"($dir)\" && nvim \"($realfile)\"; exec zsh"
}

# Task execution with notification
def "notify on done" [
    task: closure # The task closure to execute and time
] {
    # Execute a task and send a notification when completed with duration
    let start = date now
    let result = do $task
    let end = date now
    let total = $end - $start | format duration sec
    let body = $"Task completed in ($total)"
    notify -s "Task Finished" -t $body
    return $result
}
