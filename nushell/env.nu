let paths = [
  "/nix/var/nix/profiles/default/bin"
  "~/.nix-profile/bin",

  "~/.local/bin",
  "~/.cargo/bin",
  "~/.opam/default/bin",
]

$env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend ($paths | each { path expand })
    | uniq
)

$env.EDITOR = "nvim";
$env.SUDO_EDITOR = "nvim"
$env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"
