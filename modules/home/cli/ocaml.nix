{ pkgs, ... }: {
  home.packages = [ pkgs.opam ];

  xdg.configFile."utop/init.ml".text = ''
    #edit_mode_vi
  '';
}
