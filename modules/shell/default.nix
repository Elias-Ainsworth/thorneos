{
  flake.nixosModules.core =
    {
      config,
      dots,
      pkgs,
      lib,
      ...
    }:
    let
      inherit (lib) hiPrio;
      proj_dir = "${config.hj.directory}/projects";
      homeDir = config.hj.directory;
      xdg-user-dirs = {
        # xdg user dirs
        XDG_DESKTOP_DIR = "${homeDir}/Desktop";
        XDG_DOCUMENTS_DIR = "${homeDir}/Documents";
        XDG_DOWNLOAD_DIR = "${homeDir}/Downloads";
        XDG_MUSIC_DIR = "${homeDir}/Music";
        XDG_PICTURES_DIR = "${homeDir}/Pictures";
        XDG_PUBLICSHARE_DIR = "${homeDir}/Public";
        XDG_TEMPLATES_DIR = "${homeDir}/Templates";
        XDG_VIDEOS_DIR = "${homeDir}/Videos";
      };
    in
    {
      environment = {
        shellAliases = {
          ":e" = "nvim";
          ":q" = "exit";
          ":wq" = "exit";
          c = "clear";
          cat = "bat";
          ccat = "command cat";
          cp = "cp -ri";
          crate = "cargo";
          dots = "cd ${dots}";
          isodate = ''date -u "+%Y-%m-%dT%H:%M:%SZ"'';
          mime = "xdg-mime query filetype";
          mkdir = "mkdir -p";
          mount = "mount --mkdir";
          np = "cd ${proj_dir}/nixpkgs";
          open = "xdg-open";
          py = "python";
          sl = "ls";
          w = "watch -cn1 -x cat";
          coinfc = "pj coinfc";

          # cd aliases
          ".." = "cd ..";
          "..." = "cd ../..";
        };

        systemPackages = with pkgs; [
          bat
          bonk # mkdir and touch in one
          curl
          # dysk # better disk info
          ets # add timestamp to beginning of each line
          fd # better find
          fx # terminal json viewer and processor
          gzip
          htop
          jq
          killall
          procs # better ps
          (hiPrio procps) # for uptime
          ripgrep
          sd # better sed
          trash-cli
          ugrep # grep, with boolean query patterns, e.g. ug --files -e "A" --and "B"
          xdg-utils
        ];

        variables = {
          TERMINAL = "ghostty";
          EDITOR = "nvim";
          VISUAL = "nvim";
          NIXPKGS_ALLOW_UNFREE = "1";
          # xdg
          XDG_CACHE_HOME = config.hj.xdg.cache.directory;
          XDG_CONFIG_HOME = config.hj.xdg.config.directory;
          XDG_DATA_HOME = config.hj.xdg.data.directory;
          XDG_STATE_HOME = config.hj.xdg.state.directory;
        }
        // xdg-user-dirs;
      };
    };
}
