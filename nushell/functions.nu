# NixOS rebuild functions
def "nrs" [
] {
    # Rebuild and switch to new NixOS configuration
    sudo nixos-rebuild switch --flake $"($env.HOME)/.config/nixos#(hostname)"
}

def "nrb" [
] {
    # Rebuild NixOS configuration for next boot (doesn't switch current session)
    sudo nixos-rebuild boot --flake $"($env.HOME)/.config/nixos#(hostname)"
}

def "nrt" [
] {
    # Test NixOS configuration build without switching or affecting boot
    sudo nixos-rebuild test --flake $"($env.HOME)/.config/nixos#(hostname)"
}

def "nrv" [
    --run (-r) # Run the built VM immediately after building
] {
    # Build NixOS configuration as a virtual machine
    cd ~/Documents/Machines/NixOS
    nixos-rebuild build-vm --flake $"($env.HOME)/.config/nixos#(hostname)"

    if $run {
        ^$"./result/bin/run-vm-vm"
    }
}

def "nvb" [
    config_file: string # Path to the NixOS configuration file
    --run (-r) # Run the built VM immediately after building
] {
    # Build a NixOS VM from a specific configuration file
    nix-build '<nixpkgs/nixos>' -A vm -I nixpkgs=channel:nixos-unstable -I $"nixos-config=($config_file)"

    if $run {
        ./result/bin/run-nixos-vm
    }
}

def "nvc" [] {
    # Clean NixOS VM build results and disk images
    let has_vm_results = (try { ls result/bin/run* | is-not-empty } catch { false })
    let system_qcow = $"(hostname).qcow2"
    let nixos_qcow = "nixos.qcow2"
    let has_system_qcow = ($system_qcow | path exists)
    let has_nixos_qcow = ($nixos_qcow | path exists)

    if $has_vm_results {
        rm -rf result
        print "VM build results cleaned"
    }

    if $has_system_qcow {
        rm -f $system_qcow
        print $"VM disk image ($system_qcow) cleaned"
    }

    if $has_nixos_qcow {
        rm -f $nixos_qcow
        print $"VM disk image ($nixos_qcow) cleaned"
    }

    if (not $has_vm_results and not $has_system_qcow and not $has_nixos_qcow) {
        print "No VM results or disk images found to clean"
    }
}

# Home Manager functions
def "hrs" [
] {
    # Rebuild and switch Home Manager configuration
    home-manager switch --flake $"($env.HOME)/.config/nixos#vault@(hostname)"
}

def "hrb" [
] {
    # Build Home Manager configuration without switching
    home-manager build --flake $"($env.HOME)/.config/nixos#vault@(hostname)"
}

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
