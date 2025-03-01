{...}: {
  imports = [
    ../common
    ../features/desktop
    ../features/cli
    ../features/dev
    ./home.nix
    ./dotfiles
    ./impermanence.nix
  ];

  features = {
    cli = {
      zsh.enable = true;
      tmux.enable = true;
      neofetch.enable = true;
    };

    desktop = {
      fonts.enable = true;
      wayland.enable = true;
      browser.enable = true;
    };

    dev = {
      lsp.enable = true;
      linters.enable = true;
      debuggers.enable = true;
    };
  };
}
