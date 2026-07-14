{ pkgs, ... }: {
  home.packages = with pkgs; [
    typst
    tinymist # Typst LSP
    typstyle
  ];
}
