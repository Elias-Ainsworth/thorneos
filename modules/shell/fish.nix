{
  flake.nixosModules.core =
    {
      config,
      pkgs,
      ...
    }:
    let
      fish-completion-sync = pkgs.fetchFromGitHub {
        owner = "iynaix";
        repo = "fish-completion-sync";
        rev = "4f058ad2986727a5f510e757bc82cbbfca4596f0";
        hash = "sha256-kHpdCQdYcpvi9EFM/uZXv93mZqlk1zCi2DRhWaDyK5g=";
      };
    in
    {
      programs = {
        fish = {
          enable = true;

          shellAbbrs = config.environment.shellAliases // {
            ehistory = ''nvim "${config.hj.xdg.data.directory}/fish/fish_history"'';
          };
          shellInit =
            /* fish */ ''
              set fish_greeting

              function fish_user_key_bindings
                fish_default_key_bindings -M insert
                fish_vi_key_bindings --no-erase insert
              end

              fish_vi_key_bindings

              source ${fish-completion-sync}/init.fish
            '';
        };
      };

      environment = {
        pathsToLink = ["/share/fish"];
        systemPackages = [fish-completion-sync];
      };
    };
}
