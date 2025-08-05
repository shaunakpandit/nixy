{
  config,
  lib,
  ...
}: {
  imports = [
    # Choose your theme here:
    ../../themes/catppuccin.nix
  ];

  config.var = {
    hostname = "nexus";
    username = "shaunak";
    configDirectory =
      "/home/"
      + config.var.username
      + "/.config/nixos"; # The path of the nixos configuration directory

    keyboardLayout = "fr";

    location = "Washington DC";
    timeZone = "America/New_York";
    defaultLocale = "en_US.UTF-8";
    # extraLocale = "fr_FR.UTF-8";

    git = {
      name = "shaunak pandit";
      email = "shaunakdpandit@gmail.com";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;
  };

  # Let this here
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}
