{
  inputs,
  globals,
  ...
}:
{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      programs.dconf.enable = true;
      services.gvfs.enable = true;
      services.upower.enable = true;

      hjem = {
        clobberByDefault = true;
        linker = inputs.hjem.packages.${pkgs.stdenv.hostPlatform.system}.smfh;
        users."${globals.user}" = {
          user = "${globals.user}";
          directory = "/home/${globals.user}";
        };

      };
    };
}
