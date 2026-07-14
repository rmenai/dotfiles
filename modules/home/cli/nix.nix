{ pkgs, ... }: {
  home.shellAliases = {
    r = "nix repl";
  };

  home.packages = with pkgs; [
    nixfmt
    statix
  ];
}
