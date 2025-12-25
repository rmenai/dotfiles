{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.editors.neovim;
in
{
  options.features.apps.editors.neovim = {
    enable = lib.mkEnableOption "Neovim";
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    home.packages = with pkgs; [
      vimgolf
      lazygit
      curl
      fzf
    ];

    xdg.mimeApps.defaultApplications = {
      # Text/Code files
      "text/plain" = "nvim-wezterm.desktop";
      "text/x-python" = "nvim-wezterm.desktop";
      "text/x-shellscript" = "nvim-wezterm.desktop";
      "application/x-shellscript" = "nvim-wezterm.desktop";
      "application/javascript" = "nvim-wezterm.desktop";
      "text/markdown" = "nvim-wezterm.desktop";
      "text/rust" = "nvim-wezterm.desktop";
      "application/json" = "nvim-wezterm.desktop";
      "application/yaml" = "nvim-wezterm.desktop";

      "text/x-csrc" = "nvim-wezterm.desktop";
      "text/x-chdr" = "nvim-wezterm.desktop";
      "text/x-c++src" = "nvim-wezterm.desktop";
      "text/x-c++hdr" = "nvim-wezterm.desktop";
      "text/x-ocaml" = "nvim-wezterm.desktop";
    };

    features.core.dotfiles.links = {
      nvim = "nvim";
      lazygit = "lazygit";
    };
  };
}
