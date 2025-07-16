{ config, lib, ... }: {
  options.features.desktop.catppuccin = {
    enable = lib.mkEnableOption "Catppuccin theme globally";
  };

  config = lib.mkIf config.features.desktop.catppuccin.enable {
    catppuccin = {
      flavor = "mocha";
      accent = "pink";

      aerc.enable = true;
      alacritty.enable = true;
      bottom.enable = true;
      brave.enable = true;
      btop.enable = true;
      cava.enable = true;
      chromium.enable = true;
      cursors.enable = true;
      cursors.accent = "dark";
      delta.enable = true;
      element-desktop.enable = true;
      fcitx5.enable = true;
      firefox.profiles.default.enable = true;
      fish.enable = true;
      foot.enable = true;
      freetube.enable = true;
      fuzzel.enable = true;
      fzf.enable = true;
      gh-dash.enable = true;
      ghostty.enable = true;
      gitui.enable = true;
      glamour.enable = true;
      gtk.enable = true;
      helix.enable = true;
      imv.enable = true;
      k9s.enable = true;
      kitty.enable = true;
      kvantum.enable = true;
      lazygit.enable = true;
      librewolf.profiles.default.enable = true;
      lsd.enable = true;
      mako.enable = true;
      mangohud.enable = true;
      micro.enable = true;
      mpv.enable = true;
      newsboat.enable = true;
      polybar.enable = true;
      qutebrowser.enable = true;
      rio.enable = true;
      sioyek.enable = true;
      skim.enable = true;
      spotify-player.enable = true;
      swaync.enable = true;
      thunderbird.enable = true;
      tofi.enable = true;
      vesktop.enable = true;
      vivaldi.enable = true;
      vscode.profiles.default.enable = true;
      wlogout.enable = true;
      zed.enable = true;
      swaylock.enable = true;
      sway.enable = true;
      obs.enable = true;
      rofi.enable = true;
      dunst.enable = true;
      hyprland.enable = true;
      hyprlock.enable = true;
    };

    qt = {
      enable = true;
      style.name = "kvantum";
      platformTheme.name = "kvantum";
    };

    gtk.enable = true;
  };
}
