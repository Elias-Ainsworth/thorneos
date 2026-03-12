{lib, pkgs, inputs, ... }:
{
  flake.nixosModules.wm = {pkgs, lib, inputs, config, ...}: {
  # install package
    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      # ... maybe other stuff
    ];


    hj.xdg =
      let
        official = "https://github.com/noctalia-dev/noctalia-plugins";
      in
      {
        config.files = {
          "noctalia/settings.json" = {
            generator = lib.strings.toJSON;
            value = {
              # TODO: configure bar and minimal widgets
            };
          };
          "noctalia/plugins.json" = {
            generator = lib.strings.toJSON;
            value = {
              sources = [
                {
                  enabled = true;
                  name = "Official Noctalia Plugins";
                  url = official;
                }
              ];
              states = {};
            };
          };
        };
        
      };
    custom.programs.niri.settings = {
      # bar blur
      spawn-at-startup = [
          ["noctalia-shell"]
      ];
      layer-rules = [
        {
          matches = [ { namespace = "^noctalia-background-.*$"; } ];
          background-effect = {
            blur = true;
          };
        }
      ];

      # settings window blur
      window-rules = [
        {
          matches = [ { app-id = "^dev.noctalia.noctalia-qs$"; } ];

          background-effect = {
            blur = true;
          };
        }
      ];
    };

  };
}
