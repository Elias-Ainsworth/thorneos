{ inputs, lib, pkgs, ... }:
{
  flake.nixosModules.core = {
    programs.dconf.enable = true;
    services.gvfs.enable = true;

    hjem = {
      users."elias-ainsworth".enable = true;
      clobberByDefault = true;
    };
  };
}
