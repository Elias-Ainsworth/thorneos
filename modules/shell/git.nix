{ globals, ... }:
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
            name = globals.name;
            email = globals.email;
          };
        };
      };
    };
  };
}
