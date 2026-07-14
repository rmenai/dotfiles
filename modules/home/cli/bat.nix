{ pkgs, ... }:
{
  home = {
    shellAliases.cat = "bat";
    sessionVariables.MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };

  programs.bat = {
    enable = true;
    extraPackages = builtins.attrValues {
      inherit (pkgs.bat-extras) batgrep batdiff batman;
    };
  };

  catppuccin.bat.enable = true;
}
