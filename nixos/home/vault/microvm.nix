{ func, lib, ... }: {
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
    profiles = { core.enable = true; };

    dotfiles.enable = true;

    system = {
      nix.enable = true;
      home.enable = true;
      sops.enable = true;
    };

    services = { ssh.enable = true; };

    apps = {
      terminals.wezterm.enable = true;

      shell = {
        nushell.enable = true;
        zsh.enable = true;
      };
    };
  };
}
