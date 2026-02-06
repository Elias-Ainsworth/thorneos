{
flake.nixosModules.core =
  { host, pkgs, lib, ... }:
  {
    networking.hostName = "${host}";
    networking.networkmanager.enable = true;

    time.timeZone = "America/Phoenix";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # Configure keymap in X11
    services.xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
      excludePackages = [pkgs.xterm];
    };

    # Get lost...please
    programs.nano.enable = lib.mkForce false;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = ["nix-command" "flakes"];

    # Don't change this you idiot.
    system.stateVersion = "25.11";
  };
}
