# X CLI Tool - Complete Specification

## Overview

`x` is a unified CLI tool for managing NixOS systems, home-manager configurations, impermanence, and related operations. It consolidates nixos-rebuild, home-manager, nixos-anywhere, colmena, and custom impermanence management into a single, efficient interface.

## Global Options

```bash
x [GLOBAL_OPTIONS] <COMMAND> [COMMAND_OPTIONS]
```

### Global Flags

- `--host <HOST>` - Target host (defaults to current hostname)
- `--config <PATH>` - Path to configuration file (default: `~/.config/x/config.toml`)
- `--dry-run` - Show what would be done without executing
- `--verbose` - Verbose output
- `--quiet` - Suppress non-error output
- `--parallel` - Enable parallel operations where applicable
- `--help` - Show help information
- `--version` - Show version information

## Commands

### System Operations (`x system`)

Manages NixOS system configurations and deployments.

#### `x system rebuild [OPTIONS]`

Rebuilds the current system configuration.

- `--spec <SPECIALIZATION>` - Switch to specialization
- `--boot` - Set configuration for next boot only
- `--test` - Test configuration temporarily
- `--switch` - Switch to configuration immediately (default)
- `--flake <PATH>` - Path to flake (default: current directory)
- `--impure` - Allow impure evaluation
- `--show-trace` - Show detailed error traces

#### `x system deploy [OPTIONS]`

Deploy configuration to remote host.

- `--host <HOST>` - Target host (required for remote)
- `--boot` - Set as boot configuration
- `--test` - Test deployment temporarily
- `--switch` - Switch immediately (default)
- `--spec <SPECIALIZATION>` - Target specialization
- `--build-host <HOST>` - Build on different host
- `--copy-only` - Only copy, don't activate

#### `x system rollback [OPTIONS]`

Rollback to previous system generation.

- `--generation <NUM>` - Specific generation number
- `--list` - List available generations
- `--boot` - Set rollback for next boot only

#### `x system generations [OPTIONS]`

List system generations.

- `--limit <NUM>` - Limit number of generations shown
- `--details` - Show detailed information
- `--json` - Output in JSON format

#### `x system cleanup [OPTIONS]`

Clean up old system generations.

- `--older-than <DURATION>` - Remove generations older than duration (e.g., "30d", "1w")
- `--keep <NUM>` - Keep N most recent generations
- `--dry-run` - Show what would be removed

#### `x system boot-entry [OPTIONS]`

Manage boot entries.

- `--add --gen <NUM>` - Add generation to boot menu
- `--remove --gen <NUM>` - Remove generation from boot menu
- `--list` - List current boot entries
- `--default <NUM>` - Set default boot entry

#### `x system specializations`

List available specializations for current/target host.

- `--host <HOST>` - Target host
- `--details` - Show specialization details

### Home Manager Operations (`x home`)

Manages home-manager configurations.

#### `x home switch [OPTIONS]`

Switch home-manager configuration.

- `--flake <PATH>` - Path to flake
- `--backup` - Create backup of existing config

#### `x home build [OPTIONS]`

Build home-manager configuration without switching.

- `--flake <PATH>` - Path to flake
- `--check` - Check configuration validity

#### `x home rollback [OPTIONS]`

Rollback home-manager configuration.

- `--generation <NUM>` - Specific generation
- `--list` - List available generations

#### `x home generations`

List home-manager generations.

- `--limit <NUM>` - Limit results
- `--details` - Detailed information

### Impermanence Operations (`x persist`)

Manages impermanence and persistent storage.

#### `x persist diff [TARGET]`

Compare current state with persistent storage.

- No argument: BTRFS diff with baseline snapshot
- `root`: Compare `/` with `/persist/system`
- `<directory>`: Compare `/<directory>` with `/persist/<directory>`

#### `x persist save <PATH>`

Save file/directory to persistent storage.

- `<PATH>` - File or directory to save

#### `x persist sync`

Sync dotfiles repositories.

- Uses repositories defined in config

#### `x persist status`

Show impermanence status and recent changes.

#### `x persist snapshot [OPTIONS]`

Manage BTRFS snapshots.

- `--create` - Create new snapshot
- `--list` - List available snapshots
- `--restore <SNAPSHOT>` - Restore from snapshot

### Configuration Management (`x config`)

Manages configuration files and validation.

#### `x config validate [OPTIONS]`

Validate configuration syntax.

- `--flake <PATH>` - Path to flake
- `--host <HOST>` - Validate specific host config

#### `x config format [OPTIONS]`

Format Nix configuration files.

- `--check` - Check if formatting is needed
- `--path <PATH>` - Specific path to format

#### `x config diff [OPTIONS]`

Compare configurations.

- `--host <HOST>` - Compare with remote host
- `--generation <NUM>` - Compare with specific generation

#### `x config template [OPTIONS]`

Generate configuration templates.

- `--host <HOST>` - Generate for new host
- `--type <TYPE>` - Template type (desktop, server, vm)

#### `x config secrets [OPTIONS]`

Manage configuration secrets.

- `--rotate` - Rotate secrets
- `--edit` - Edit secrets file
- `--rekey` - Rekey secrets for new hosts

### Virtual Machine Operations (`x vm`)

Manages virtual machine testing and deployment.

#### `x vm start [OPTIONS]`

Start VM with configuration.

- `--config <PATH>` - Configuration to test
- `--memory <SIZE>` - VM memory size
- `--cpus <NUM>` - Number of CPUs
- `--display` - Enable display
- `--ssh` - Enable SSH access

#### `x vm build [OPTIONS]`

Build VM image.

- `--config <PATH>` - Configuration path
- `--output <PATH>` - Output path for image

#### `x vm deploy [OPTIONS]`

Deploy to VM.

- `--host <HOST>` - Target VM host
- `--config <PATH>` - Configuration to deploy

### Development Operations (`x dev`)

Development and testing utilities.

#### `x dev shell [OPTIONS]`

Enter development shell.

- `--flake <PATH>` - Flake path
- `--command <CMD>` - Command to run in shell

#### `x dev build [OPTIONS]`

Build without installing.

- `--check` - Check build without output
- `--json` - JSON output format

#### `x dev test [OPTIONS]`

Test configuration.

- `--in-vm` - Test in virtual machine
- `--host <HOST>` - Test on remote host

#### `x dev bench [OPTIONS]`

Benchmark operations.

- `--rebuild-time` - Benchmark rebuild time
- `--iterations <NUM>` - Number of iterations

### Remote Management (`x remote`)

Manage remote hosts and operations.

#### `x remote list [OPTIONS]`

List configured remote hosts.

- `--status` - Show host status
- `--json` - JSON output

#### `x remote status [OPTIONS]`

Check status of remote hosts.

- `--all` - Check all hosts
- `--host <HOST>` - Check specific host

#### `x remote deploy [OPTIONS]`

Deploy to multiple hosts.

- `--parallel` - Deploy in parallel
- `--hosts <HOST1,HOST2>` - Specific hosts
- `--all` - Deploy to all hosts

#### `x remote ssh [OPTIONS]`

SSH to remote host.

- `--host <HOST>` - Target host (required)
- `--command <CMD>` - Command to execute

### Package Management (`x pkg`)

Package search and management utilities.

#### `x pkg search <QUERY>`

Search for packages.

- `--limit <NUM>` - Limit results
- `--json` - JSON output

#### `x pkg install [OPTIONS] <PACKAGE>`

Temporary package installation.

- `--temp` - Install temporarily
- `--profile <PROFILE>` - Install to profile

#### `x pkg history [OPTIONS]`

Show package installation history.

- `--limit <NUM>` - Limit results
- `--host <HOST>` - Remote host history

#### `x pkg compare [OPTIONS]`

Compare installed packages.

- `--host <HOST>` - Compare with remote host
- `--generation <NUM>` - Compare with generation

### Monitoring & Diagnostics (`x monitor`)

System monitoring and diagnostics.

#### `x monitor status [OPTIONS]`

Show system status.

- `--services` - Show service status
- `--resources` - Show resource usage

#### `x monitor logs [OPTIONS]`

Show system logs.

- `--service <SERVICE>` - Specific service logs
- `--follow` - Follow log output
- `--lines <NUM>` - Number of lines

#### `x monitor profile [OPTIONS]`

System profile information.

- `--compare <PROFILE>` - Compare with another profile
- `--details` - Detailed profile information

#### `x monitor health [OPTIONS]`

Run system health checks.

- `--critical-only` - Show only critical issues
- `--json` - JSON output

### Backup & Sync (`x backup`)

Backup and synchronization operations.

#### `x backup create [OPTIONS]`

Create system backup.

- `--snapshot` - Create BTRFS snapshot
- `--include <PATHS>` - Include specific paths
- `--exclude <PATHS>` - Exclude specific paths

#### `x backup restore [OPTIONS]`

Restore from backup.

- `--from <BACKUP>` - Backup to restore from
- `--preview` - Preview restore operation

#### `x backup list [OPTIONS]`

List available backups.

- `--details` - Show backup details
- `--json` - JSON output

### Utility Commands (`x utils`)

Miscellaneous utility operations.

#### `x utils watch [OPTIONS]`

Watch for changes and auto-rebuild.

- `--auto-rebuild` - Auto rebuild on changes
- `--paths <PATHS>` - Paths to watch

#### `x utils tunnel [OPTIONS]`

SSH tunneling utilities.

- `--host <HOST>` - Target host
- `--port <PORT>` - Port to tunnel
- `--local-port <PORT>` - Local port

#### `x utils migrate [OPTIONS]`

Migrate configurations between hosts.

- `--from-host <HOST>` - Source host
- `--to-host <HOST>` - Target host

## Configuration File (`~/.config/x/config.toml`)

```toml
[defaults]
flake_path = "."
specialization = "desktop"
editor = "nvim"

[hosts]
malloc = { ip = "192.168.1.100", user = "admin", ssh_key = "~/.ssh/malloc" }
fork = { ip = "192.168.1.101", user = "vault", ssh_key = "~/.ssh/fork" }
gpio = { ip = "192.168.1.102", user = "vault" }

[persist]
uuid = "dfe71357-a2e8-479a-b976-0cd1269cbfa2"
repos = [
    "/home/vault/.dotfiles",
    "/home/vault/.config"
]

[vm]
default_memory = "4G"
default_cpus = 2
display = false

[backup]
default_location = "/backup"
retention_days = 30

[development]
auto_format = true
check_on_build = true
```

## Exit Codes

- `0` - Success
- `1` - General error
- `2` - Configuration error
- `3` - Network/remote error
- `4` - Permission error
- `5` - Build/compilation error

## Shell Completion

The tool supports shell completion for bash, zsh, and fish:

```bash
# Generate completion
x completion bash > /etc/bash_completion.d/x
x completion zsh > /usr/share/zsh/site-functions/_x
x completion fish > ~/.config/fish/completions/x.fish
```

## Examples

### Common Daily Operations

```bash
# Local operations
x system rebuild
x system rebuild --spec gaming
x home switch
x persist diff

# Remote operations
x system deploy --host malloc --boot
x remote status --all
x config validate --host fork

# Development workflow
x dev test --in-vm
x vm start --config ./test-config
x config format --check
```

### Advanced Operations

```bash
# Parallel deployment
x remote deploy --parallel --hosts malloc,fork,gpio

# Backup and restore
x backup create --snapshot
x backup restore --from snapshot-20240715

# System maintenance
x system cleanup --older-than 30d
x system generations --limit 10
x monitor health --critical-only
```

## Integration with Nix Flakes

The tool is designed to work seamlessly with Nix flakes and can be distributed as a flake package:

```nix
{
  packages.x = pkgs.rustPlatform.buildRustPackage {
    pname = "x";
    version = "1.0.0";
    src = ./x;
    # ... package configuration
  };
}
```
