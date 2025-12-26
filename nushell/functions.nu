# Yazi file manager with directory change
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# A way to load ocaml env
def --env opam-env [] {
    opam env --shell=powershell
    | parse "$env:{key} = '{val}'"
    | transpose -rd
    | load-env
}
