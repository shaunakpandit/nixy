# Hypridle is a daemon that listens for user activity and runs commands when the user is idle.
{
  pkgs,
  lib,
  ...
}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        { 
            timeout = 180;
            on-timeout = "brightnessctl -s && brightnessctl s 1%";
            on-resume = "brightnessctl -r";
        }

        {
          timeout = 190;
          on-timeout = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
        }

        {
          timeout = 200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on"; 
        }
      ];
    };
  };
  systemd.user.services.hypridle.Unit.After =
    lib.mkForce "graphical-session.target";
}
