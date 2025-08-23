{ config, func, lib, pkgs, ... }: {
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
    impermanence.enable = true;
    persist.enable = true;

    system = {
      nix.enable = true;
      home.enable = true;
      mime.enable = true;
      sops.enable = true;
    };

    services = {
      adjust-power.enable = true;
      mpris.enable = true;
      ssh.enable = true;
    };

    desktop = {
      hyprland.enable = true;
      catppuccin.enable = true;
      fonts.enable = true;
    };

    apps = {
      gaming = {
        steam.enable = true;
        heroic.enable = true;
        lutris.enable = false;
        prism.enable = true;
        itch.enable = true;
      };

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
        vivaldi.enable = true;
        chromium.enable = true;
        firefox.enable = true;
      };

      socials = {
        discord.enable = true;
        whatsapp.enable = true;
      };

      development = {
        core.enable = true;
        tools.enable = true;

        android.enable = true;
        godot.enable = true;
        ai.enable = true;

        helix.enable = true;
        jetbrains.enable = true;

        latex.enable = true;
        node.enable = true;
        ocaml.enable = true;
        python.enable = true;
        r.enable = true;
        rust.enable = true;
      };

      misc = {
        media.enable = true;
        blender.enable = true;
        obsidian.enable = true;
        zathura.enable = true;
      };
    };
  };

  home.packages = with pkgs; [ bitwarden-desktop ];

  programs.ssh.extraConfig = ''
    UpdateHostKeys ask
    AddKeysToAgent yes

    Host kali
      HostName kali
      User vault
      IdentityFile /home/${config.spec.user}/.ssh/id_ed25519_vm
      ForwardAgent yes
      ForwardX11 yes
      ForwardX11Trusted yes

    Host flare
      HostName flare
      User vault
      IdentityFile /home/${config.spec.user}/.ssh/id_ed25519_vm
      ForwardAgent yes

    Host vm
      HostName vm
      User vault
      IdentityFile /home/${config.spec.user}/.ssh/id_ed25519_vm
      ForwardAgent yes
      ForwardX11 yes
      ForwardX11Trusted yes

    Host kernel
      HostName kernel
      User vault
      IdentityFile /home/${config.spec.user}/.ssh/id_ed25519
      ForwardAgent yes
      ForwardX11 yes
      ForwardX11Trusted yes
  '';

  features.dotfiles = {
    paths = {
      ".config/easyeffects" = lib.mkDefault "easyeffects";
      ".config/obs-studio" = lib.mkDefault "obs-studio";
    };
  };

  features.persist = { directories = { ".vagrant.d" = lib.mkDefault true; }; };
}
