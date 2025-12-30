{ |cmd_name|
  let install = { |pkgs|
    $pkgs | each {|pkg| $"  nix shell nixpkgs#($pkg)" }
  }
  let run_once = { |pkgs|
    $pkgs | each {|pkg| $"  nix shell nixpkgs#($pkg) --command '($cmd_name) ...'" }
  }
  let single_pkg = { |pkg|
    let lines = [
      $"The program '($cmd_name)' is currently not installed."
      ""
      "You can run it once with:"
      (do $run_once [$pkg] | get 0)
    ]
    $lines | str join "\n"
  }
  let multiple_pkgs = { |pkgs|
    let lines = [
      $"The program '($cmd_name)' is currently not installed. It is provided by several packages."
      ""
      "You can run it once with:"
      (do $run_once $pkgs | str join "\n")
    ]
    $lines | str join "\n"
  }
  let pkgs = (nix-locate --minimal --no-group --type x --type s --whole-name --at-root $"/bin/($cmd_name)" | lines)
  let len = ($pkgs | length)
  let ret = match $len {
    0 => null,
    1 => (do $single_pkg ($pkgs | get 0)),
    _ => (do $multiple_pkgs $pkgs),
  }
  return $ret
}
