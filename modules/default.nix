{ inputs, lib, ... }:
{
  flake.nixosModules.core = {
    programs.dconf.enable = true;
    services.gvfs.enable = true;

    hjem = {
      clobberByDefault = true;
      linker = inputs.hjem.packages.${pkgs.stdenv.hostPlatform.system}.smfh;
    };
  };
}
