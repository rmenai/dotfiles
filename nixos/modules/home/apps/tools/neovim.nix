{ config, lib, pkgs, ... }: {
  options.features.apps.tools.neovim = {
    enable = lib.mkEnableOption "Neovim text editor";
  };

  config = lib.mkIf config.features.apps.tools.neovim.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    home.packages = [ pkgs.vimgolf ];

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

    features.dotfiles = { paths = { ".config/nvim" = lib.mkDefault "nvim"; }; };
    features.persist = { directories = { ".vimgolf" = lib.mkDefault true; }; };
  };
}
