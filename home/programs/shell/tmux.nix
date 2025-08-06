{
  lib,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    # use the stock tmux from nixpkgs
    package = pkgs.tmux;

    # plugins that live in nixpkgs
    plugins = with pkgs.tmuxPlugins;
      [
        vim-tmux-navigator
        cpu
        tmux-fzf
        catppuccin
        tmux-sessionx
        sensible
        online-status
      ];

    extraConfig = ''
      ##############################################################################
      # GENERAL SETTINGS
      ##############################################################################
      set -g mouse on
      set -g default-terminal "tmux-256color"

      # status bar – catppuccin rice
      set -g status-position top
      set -g status-style "bg=#{@thm_bg}"
      set -g status-justify "absolute-centre"

      setw -g pane-border-status top
      setw -g pane-border-format ""
      setw -g pane-active-border-style "bg=#{@thm_bg},fg=#{@thm_overlay_0}"
      setw -g pane-border-style "bg=#{@thm_bg},fg=#{@thm_surface_0}"
      setw -g pane-border-lines single

      set -wg automatic-rename on
      set -g automatic-rename-format "Window"

      set -g window-status-format " #I#{?#{!=:#{window_name},Window},: #W,} "
      set -g window-status-style "bg=#{@thm_bg},fg=#{@thm_rosewater}"
      set -g window-status-last-style "bg=#{@thm_bg},fg=#{@thm_peach}"
      set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_bg}"
      set -g window-status-bell-style "bg=#{@thm_red},fg=#{@thm_bg},bold"
      set -gF window-status-separator "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}]│"
      set -g window-status-current-format " #I#{?#{!=:#{window_name},Window},: #W,} "
      set -g window-status-current-style "bg=#{@thm_peach},fg=#{@thm_bg},bold"

      ##############################################################################
      # RICING & CATPPUCCIN OPTIONS
      ##############################################################################
      set -g @catppuccin_flavor             "macchiato"
      set -g @catppuccin_status_background  "none"
      set -g @catppuccin_window_status_style "none"
      set -g @catppuccin_pane_status_enabled "off"
      set -g @catppuccin_pane_border_status "off"

      set -g @online_icon  "ok"
      set -g @offline_icon "nok"

      ##############################################################################
      # STATUS-LEFT
      ##############################################################################
      set -g status-left-length 100
      set -g status-left ""
      set -ga status-left "#{?client_prefix,#[fg=#{@thm_green} bold]PREFIX ,#{?#{==:#{pane_mode},copy-mode},#[fg=#{@thm_yellow} bold]COPY ,#[fg=#{@thm_mauve} bold]NORMAL }}"
      set -ga status-left "#{?client_prefix,#{#[fg=#{@thm_green},bold]  #S },#{#[fg=#{@thm_mauve}]  #S }}"
      set -ga status-left "#[fg=#{@thm_overlay_0},none]│"
      set -ga status-left "#[fg=#{@thm_blue}]  #{pane_current_command} "
      set -ga status-left "#[fg=#{@thm_overlay_0},none]│"
      set -ga status-left "#[fg=#{@thm_blue}]  #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "
      set -ga status-left "#[fg=#{@thm_overlay_0},none]#{?window_zoomed_flag,│,}"
      set -ga status-left "#[fg=#{@thm_yellow}]#{?window_zoomed_flag,  zoom ,}"

      ##############################################################################
      # STATUS-RIGHT
      ##############################################################################
      set -g status-right-length 100
      set -g status-right ""
      set -g status-right '#[fg=#{@thm_blue}]CPU #{cpu_percentage} '
      set -ga status-right "#[fg=#{@thm_overlay_0},none]│"
      set -ag status-right '#[fg=#{@thm_blue}] MEM #{ram_percentage} '
      set -ga status-right "#[fg=#{@thm_overlay_0},none]│"
      set -ga status-right "#[fg=#{@thm_blue}] 󰭦 %Y-%m-%d 󰅐 %H:%M "

      ##############################################################################
      # KEYBINDINGS & REMAPS
      ##############################################################################
      # Prefix → C-a
      unbind C-b
      set-option -g prefix C-a
      bind-key C-a send-prefix

      # Pane splitting
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf

      # Vim navigation
      bind -n C-Left  select-pane -L
      bind -n C-Right select-pane -R
      bind -n C-Up    select-pane -U
      bind -n C-Down  select-pane -D

      # Move windows
      bind-key -n C-S-h swap-window -t -1\; select-window -t -1
      bind-key -n C-S-l swap-window -t +1\; select-window -t +1

      # Rename window
      bind-key j command-prompt -I "#W" "rename-window '%%'"

      # tmux-zap defaults
      unbind d
      bind-key h run-shell "tmux popup -E -w 50% -h 40% zap"
      # unbind d
      # set -g @zap_key    d
      # set -g @zap_width  '50%'
      # set -g @zap_height '40%'

      # tmux-sessionx default bind
      set -g @sessionx-bind o
    '';
  };
}
