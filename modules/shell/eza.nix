{
  self,
  inputs,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    {
      packages = {
        eza' = inputs.wrappers.lib.wrapPackage {
          inherit pkgs;
          package = pkgs.eza;
          flags = {
            "--icons" = true;
            "--header" = true;
            "--octal-permissions" = true;
            "--hyperlink" = true;
          };
        };
      };
    };
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment = {
        systemPackages = [
          self.packages.${pkgs.stdenv.hostPlatform.system}.eza'
        ];
        shellAliases = {
          ls = "eza";
          ll = "eza -l";
          la = "eza -a";
        };
      };
    };
}
