{ pkgs, ... }: {
  home.packages = [ (pkgs.blender.override { cudaSupport = true; }) ];
}
