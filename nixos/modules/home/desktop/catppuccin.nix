{
  config,
  lib,
  pkgs,
  ...
}:

let
  # gradiencePreset = pkgs.fetchurl {
  #   url =
  #     "https://raw.githubusercontent.com/GradienceTeam/Community/next/official/catppuccin-mocha.json";
  #   hash = "sha256-4/RVQF6irDueswEXWtmn2CCmyN7VQtQPrDAeg45cTPk=";
  # };
  # gradienceBuild = pkgs.stdenv.mkDerivation {
  #   name = "gradience-build";
  #   phases = [ "buildPhase" "installPhase" ];
  #   nativeBuildInputs = [ pkgs.gradience ];
  #   buildPhase = ''
  #     shopt -s nullglob
  #     export HOME=$TMPDIR
  #     mkdir -p $HOME/.config/presets
  #     gradience-cli apply -p ${gradiencePreset} --gtk both
  #   '';
  #   installPhase = ''
  #     mkdir -p $out
  #     cp -r .config/gtk-4.0 $out/
  #     cp -r .config/gtk-3.0 $out/
  #   '';
  # };

in
{
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
      # cursors.enable = true;
      # cursors.accent = "dark";
      delta.enable = true;
      element-desktop.enable = true;
      fcitx5.enable = true;
      fish.enable = true;
      foot.enable = true;
      freetube.enable = true;
      fuzzel.enable = true;
      fzf.enable = true;
      gh-dash.enable = true;
      ghostty.enable = true;
      gitui.enable = true;
      glamour.enable = true;
      gtk.icon.enable = true;
      helix.enable = true;
      imv.enable = true;
      k9s.enable = true;
      kitty.enable = true;
      kvantum.enable = true;
      lazygit.enable = true;
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

    gtk = {
      enable = true;
      font.name = "Inter:medium";
      theme.name = "adw-gtk3-dark";
      theme.package = pkgs.adw-gtk3;

      # gtk3 = {
      #   extraCss = builtins.readFile "${gradienceBuild}/gtk-3.0/gtk.css";
      #   extraConfig = {
      #     gtk-application-prefer-dark-theme = 1;
      #     color-scheme = "prefer-dark";
      #   };
      # };
      #
      # gtk4 = {
      #   extraCss = builtins.readFile "${gradienceBuild}/gtk-4.0/gtk.css";
      #   extraConfig = {
      #     gtk-application-prefer-dark-theme = 1;
      #     color-scheme = "prefer-dark";
      #   };
      # };
    };

    # home.pointerCursor = {
    #   size = 24;
    #   gtk.enable = true;
    #   x11.enable = true;
    # };
  };
}
