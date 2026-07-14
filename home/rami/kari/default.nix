{ pkgs, ... }: {
  imports = [
    ./core.nix
    ./scratch.nix
    ./ssh.nix

    ../../../modules/home/desktop/void

    ../../../modules/home/system/mpris.nix
    ../../../modules/home/system/nix.nix

    ../../../modules/home/apps/firefox.nix
    ../../../modules/home/apps/chromium.nix

    # ../../../modules/home/apps/zathura.nix
    # ../../../modules/home/apps/swayimg.nix
    #
    # ../../../modules/home/apps/mangohud.nix
    # ../../../modules/home/apps/heroic.nix
    # ../../../modules/home/apps/lutris.nix
    # ../../../modules/home/apps/discord.nix

    ../../../modules/home/apps/anki.nix

    ../../../modules/home/apps/kitty.nix
    ../../../modules/home/apps/foot.nix

    ../../../modules/home/cli/nushell
    ../../../modules/home/cli/zellij

    ../../../modules/home/cli/git.nix
    ../../../modules/home/cli/ssh.nix

    ../../../modules/home/cli/neovim
    ../../../modules/home/cli/direnv.nix
    ../../../modules/home/cli/atuin.nix
    ../../../modules/home/cli/yazi.nix
    ../../../modules/home/cli/fzf.nix
    ../../../modules/home/cli/zoxide.nix
    ../../../modules/home/cli/bat.nix

    # ../../../modules/home/cli/btop.nix

    ../../../modules/home/cli/gcc.nix
    ../../../modules/home/cli/cpp.nix
    ../../../modules/home/cli/lua.nix
    ../../../modules/home/cli/nix.nix
    # ../../../modules/home/cli/ocaml.nix
    ../../../modules/home/cli/python.nix
    ../../../modules/home/cli/rust.nix
    # ../../../modules/home/cli/typist.nix
    # ../../../modules/home/cli/node.nix
  ];

  # TODO: implement interface for global fonts, default apps, etc...
  # TODO: write detailed documentation of everything
  # TODO: add mime support

  home.packages = with pkgs; [
    curl
    ripgrep
    ripgrep-all
    dua
    dust
    glow
    tokei
    jc

    obsidian

    # mpv
    # audacity
    # ffmpeg
    # gimp
    # imagemagick
    # kdePackages.kdenlive
    # krita
    # oculante
    # termusic
    # yt-dlp

    # itch
    # prismlauncher
    # hyperfine

    # vscode
    # jetbrains-toolbox
    # godot

    # virt-viewer
    # vagrant
    # packer
  ];

  programs = {
    home-manager.enable = true;
  };

  home = {
    shellAliases = {
      hibernate = "systemctl hibernate";
      suspend = "systemctl suspend";

      ll = "ls -l";
      la = "ls -a";
    };

    sessionPath = [
      "~/.local/bin"
    ];
  };
}
