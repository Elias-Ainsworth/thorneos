{
  flake.nixosModules.core = {
    programs = {
      git = {
        enable = true;

        config = {
          init = {
            defaultBranch = "main";
          };
          user = {
            name = "Elias Ainsworth";
            email = "pilum-murialis.toge@proton.me";
          };
        };
      };
    };
  };
}
