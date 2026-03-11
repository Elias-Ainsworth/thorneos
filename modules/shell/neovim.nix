{
  flake.nixosModules.core =
    {
      dots,
      inputs,
      pkgs,
      ...
    }:

    let
      customNeovim = inputs.thornevim.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
        inherit dots;
      };
      nvim-direnv = pkgs.writeShellApplication {
        name = "nvim-direnv";
        runtimeInputs = [
          pkgs.direnv
          customNeovim
        ];
        text = # sh
          ''
            if ! direnv exec "$(dirname "$1")" nvim "$@"; then
                nvim "$@"
            fi
          '';
      };
    in
    {
      environment = {
        shellAliases = {
          nano = "nvim";
          neovim = "nvim";
          v = "nvim";
        };

        systemPackages = [
          customNeovim
          nvim-direnv
        ];
      };
    };
}
