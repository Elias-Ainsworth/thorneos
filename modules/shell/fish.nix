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
        };
      };
    };
}
