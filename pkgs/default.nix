{ pkgs, ... }:
{
  ephemeral-root = pkgs.callPackage ./ep {};
}
