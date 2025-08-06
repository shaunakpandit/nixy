# My shell configuration
{
  pkgs,
  lib,
  config,
  ...
}: let
  fetch = config.theme.fetch; # neofetch, nerdfetch, pfetch
in {
  home.packages = with pkgs; [bat ripgrep tldr sesh rmtrash trash-cli];

  # Add go binaries to the PATH
  home.sessionPath = ["$HOME/go/bin"];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "pattern" "regexp" "root" "line"];
    };
    historySubstringSearch.enable = true;

    history = {
      ignoreDups = true;
      save = 10000;
      size = 10000;
    };

    profileExtra = lib.optionalString (config.home.sessionPath != []) ''
      export PATH="$PATH''${PATH:+:}${
        lib.concatStringsSep ":" config.home.sessionPath
      }"
    '';

    shellAliases = {
      vim = "nvim";
      vi = "nvim";
      v = "nvim";
      c = "clear";
      e = "exit";
      cd = "z";
      ls = "eza --icons=always --no-quotes";
      tree = "eza --icons=always --tree --no-quotes";
      sl = "ls";
      open = "${pkgs.xdg-utils}/bin/xdg-open";
      icat = "${pkgs.kitty}/bin/kitty +kitten icat";
      cat = "bat --theme=base16 --color=always --paging=never --tabs=2 --wrap=never --plain";
      mkdir = "mkdir -p";
      rm = "${pkgs.rmtrash}/bin/rmtrash";
      rmdir = "${pkgs.rmtrash}/bin/rmdirtrash";
      build = "sudo nixos-rebuild switch --flake ~/.config/nixos#nexus";

      obsidian-no-gpu = "env ELECTRON_OZONE_PLATFORM_HINT=auto obsidian --ozone-platform=x11";
      wireguard-import = "nmcli connection import type wireguard file";

      notes = "nvim ~/nextcloud/notes/index.md --cmd 'cd ~/nextcloud/notes' -c ':lua Snacks.picker.smart()'";
      note = "notes";
      tmp = "nvim /tmp/$(date | sed 's/ //g;s/\\.//g').md";

      nix-shell = "nix-shell --command zsh";

      # git
      lz = "lazygit";
      gc = "git commit";
      gcu = "git add . && git commit -m 'Update'";
      gp = "git push";
      gl = "git pull";
      gs = "git status";
      gd = "git diff";
      gco = "git checkout";
      gcb = "git checkout -b";
      gbr = "git branch";
      grs = "git reset HEAD~1";
      grh = "git reset --hard HEAD~1";

      ga = "git add .";
      gcam = "git add . && commit -m";
    };

    initContent =
      # bash
      ''
        bindkey -v
        ${
          if fetch == "neofetch"
          then pkgs.neofetch + "/bin/neofetch"
          else if fetch == "nerdfetch"
          then "nerdfetch"
          else if fetch == "pfetch"
          then "echo; ${pkgs.pfetch}/bin/pfetch"
          else ""
        }

        # =============================
        # Fzf Aliases
        # =============================
        alias ff='nvim "$(fzf --tmux 70% -m --preview="bat --color=always {}")"'
        alias al="alias | fzf"

        # =============================
        # Navigation
        # =============================
        alias ..='cd ..'
        alias nixos='cd ~/.config/nixos/'

      '';
  };
}
