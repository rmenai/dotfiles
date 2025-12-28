#!/usr/bin/env nu

print "Running first-time setup..."

print "Generating Carapace init..."
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

print "Generating Starship init..."
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save --force ($nu.data-dir | path join "vendor/autoload/starship.nu")
#
print "Generating Atuin init..."
mkdir ~/.local/share/atuin/
atuin init nu | save --force ~/.local/share/atuin/init.nu

print "Generating Zoxide init..."
mkdir ~/.local/share/zoxide
zoxide init nushell --cmd cd | save --force ~/.local/share/zoxide/zoxide.nu

print "Setup complete! Restart Nushell."
