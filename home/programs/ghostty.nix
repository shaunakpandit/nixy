{
  pkgs,
  userConfig,
  lib,
  theme,
  ...
}: {
  # Ensure alacritty package installed
  home.packages = with pkgs; [
    ghostty
  ];

  # Install alacritty via home-manager module
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Dracula+";
      font-size = 13;
      font-family = "JetBrainsMono NerdFont Mono";
      font-thicken = true;
      window-padding-x = 12;
      window-padding-y = 12;
      mouse-hide-while-typing = true;
      background-opacity = 0.3;
    };
  };
}
