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

  # TODO: add gaming apps, rocket league, ps5 controller
  # TODO: implement interface for global fonts, default apps, etc...
  # TODO: write detailed documentation of everything

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
      dotfiles.mutable = true;
    };

    services = {
      mpris.enable = true;
      mpd.enable = true;
    };

    desktop = {
      void.enable = true;
      mime.enable = true;
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
        swayimg.enable = true;
        gimp.enable = true;
      };

      gaming = {
        # steam is installed system wide
        mangohud.enable = true;
        lutris.enable = true;
        heroic.enable = true;
        prism.enable = true;
        itch.enable = true;
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
