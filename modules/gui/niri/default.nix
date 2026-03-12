{
  inputs,
  lib,
  self,
  ...
}:
{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      options.custom = {
        programs.niri = {
          settings = lib.mkOption {
            type = lib.types.submodule {
              freeformType = (pkgs.formats.json { }).type;
              # strings don't merge by default
              options.extraConfig = lib.mkOption {
                type = lib.types.lines;
                default = "";
                description = "Additional configuration lines.";
              };
            };
            description = "Niri settings, see https://github.com/Lassulus/wrappers/blob/main/modules/niri/module.nix for available options";
          };
        };
      };
    };

  flake.nixosModules.wm =
    { config, pkgs, ... }:
    let
      niriWrapped = inputs.wrappers.wrapperModules.niri.apply {
        inherit pkgs;
        inherit (config.custom.programs.niri) settings;
      };

    in
    {
      environment = {
        shellAliases = {
          niri-log = ''journalctl --user -u niri --no-hostname -o cat | awk '{$1=""; print $0}' | sed 's/^ *//' | sed 's/\x1b[[0-9;]*m//g' '';
        };
      };

      # NOTE: named workspaces are used, because dynamic workspaces are just... urgh
      # the workspaces are name W1, W2, etc as simply naming them as "1", "2", etc
      # causes waybar to just coerce them back into numbers, so workspaces end up being a
      # weird sequence of numbers and indexes on any monitor that isn't the first, e.g.
      # 6 7 3
      programs.niri = {
        enable = true;
        package = niriWrapped.wrapper;
        useNautilus = false;
      };

      xdg.portal = {
        config = {
          niri = {
            "org.freedesktop.impl.portal.FileChooser" = "gtk";
          };
        };
      };
    };
}
