{ func, lib, ... }:
{
  imports = lib.flatten [
    (map func.custom.relativeToRoot [ "modules/common" ])
    (map func.custom.relativeToRoot [ "modules/home" ])
  ];

  spec = {
    user = "vault";
    handle = "rmenai";
    userFullName = "Rami Menai";
    email = "rami@menai.me";
  };

  features = {
    profiles.core.enable = true;
    core.dotfiles.enable = true;

    apps = {
      terminals.wezterm.enable = true;
      shell.nushell.enable = true;

      tools = {
        atuin.enable = true;
        yazi.enable = true;

        btop.enable = true;
        dua.enable = true;

        neofetch.enable = true;
        ripgrep.enable = true;
        zoxide.enable = true;
      };
    };

  };

  home.stateVersion = "25.11";
}
