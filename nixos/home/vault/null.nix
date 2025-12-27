{
  config,
  func,
  lib,
  pkgs,
  ...
}:
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
    profiles = {
      core.enable = true;
    };

    core = {
      dotfiles = {
        enable = true;
        mutable = true;
      };
    };

    services = {
      mpris.enable = true;
      mpd.enable = true;
    };

    desktop = {
      niri.enable = true;
      waybar.enable = true;
      catppuccin.enable = true;
      mime.enable = false;
    };

    apps = {
      shells = {
        nushell.enable = true;
      };

      terminals = {
        kitty.enable = true;
        zellij.enable = true;
        foot.enable = true;
      };

      browsers = {
        vivaldi.enable = true;
        chromium.enable = true;
        firefox.enable = true;
      };

      editors = {
        neovim.enable = true;
        vscode.enable = true;
        jetbrains.enable = true;
      };

      tools = {
        direnv.enable = true;
        atuin.enable = true;
        yazi.enable = true;
        fzf.enable = true;

        btop.enable = true;
        dua.enable = true;

        neofetch.enable = true;
        hyprfine.enable = true;
        ripgrep.enable = true;
        zoxide.enable = true;
        bat.enable = true;
      };

      dev = {
        gcc.enable = true;
        lua.enable = true;

        nix.enable = true;
        ocaml.enable = true;
        python.enable = true;
        rust.enable = true;
      };

      media = {
        oculante.enable = true;
        zathura.enable = true;
        ffmpeg.enable = true;
        mpv.enable = true;

        audacity.enable = true;
        gimp.enable = true;
      };

      socials = {
        discord.enable = true;
        whatsapp.enable = true;
      };

      misc = {
        anki.enable = true;
        obsidian.enable = true;
      };
    };
  };

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # Remote tools
    # rustdesk

    # Virtualization tools
    # distrobox
    virt-viewer
    vagrant
    packer
  ];

  features.core.dotfiles.links = {
    "obs-studio" = "obs-studio";
  };

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
}
