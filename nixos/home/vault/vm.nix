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
    impermanence.enable = false;
    persist.enable = false;

    system = {
      nix.enable = true;
      home.enable = true;
      sops.enable = true;
      mime.enable = true;
    };

    services = {
      adjust-power.enable = true;
      mpris.enable = true;
      ssh.enable = true;
    };

    desktop = {
      hyprland.enable = true;
      fonts.enable = true;
    };

    apps = {
      gaming.enable = true;

      shell = {
        nushell.enable = true;
        zsh.enable = true;
      };

      terminals = {
        wezterm.enable = true;
        kitty.enable = true;
        tmux.enable = true;
      };

      browsers = {
        brave.enable = true;
        chromium.enable = true;
        firefox.enable = true;
      };

      socials = {
        discord.enable = true;
        whatsapp.enable = true;
      };

      development = {
        core.enable = true;

        android.enable = true;
        godot.enable = true;
        ai.enable = true;

        helix.enable = true;
        jetbrains.enable = true;
        neovim.enable = true;

        latex.enable = true;
        node.enable = true;
        ocaml.enable = true;
        python.enable = true;
        r.enable = true;
        rust.enable = true;
      };

      tools = {
        core.enable = true;
        bat.enable = true;
        eza.enable = true;
        fzf.enable = true;
        neofetch.enable = true;
        yazi.enable = true;
        zoxide.enable = true;
      };

      misc = {
        media.enable = true;
        blender.enable = true;
        obsidian.enable = true;
        zathura.enable = true;
      };
    };
  };

  features.dotfiles = {
    paths = {
      ".config/easyeffects" = lib.mkDefault "easyeffects";
      ".config/obs-studio" = lib.mkDefault "obs-studio";
    };
  };
}
