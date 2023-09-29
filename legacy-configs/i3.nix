{
  xsession.windowManager.i3 = {
    enable = true;
    
    config = {
      modifier = "Mod4";
      terminal = "kitty";

      defaultWorkspace = "workspace number 10";
      startup = [
        # { command = "picom"; always = true; notification = false; } # Picom stuff
        # { command = "i3-msg 'workspace 1; exec kitty'"; always = true; notification = false; } # Runs kitty in workspace 1
        # { command = "i3-msg 'workspace 1; exec firefox'"; always = true; notification = false; } # Starts firefox in workspace 2
        { command = "thunar --daemon"; always = true; notification = false; } # Start thunar daemon
        { command = "nitrogen --set-auto ~/wallpapers/firewatch.jpg"; always = true; notification = false; } # Set background
        { command = "i3-msg 'workspace 10; exec pavucontrol'"; always = true; notification = false; } # Start audio controller in workspace 9
        { command = "i3-msg 'workspace 10; exec noisetorch'"; always = true; notification = false; } # Start noise torch in workspace 9
        { command = "i3-msg 'workspace 9; exec discord'"; always = true; notification = false; } # Starts discord in workspace 8
      ];
    };
  };

  services.picom = {
    enable = true;
    vSync = true;
    backend = "glx";

    extraArgs = [
      "--xrender-sync"
      "--xrender-sync-fence"
    ];
  };

  programs.i3status = {
    enable = true;
    enableDefault = false;

    general = {
      interval = 1;
      colors = true;
      color_good = "#88b090";
      color_degraded = "#ccdc90";
      color_bad = "#e89393";
    };

    modules = {
      "volume master" = {
        position = 1;
        
        settings = {
          format = "VOL: %volume";
          format_muted = "VOL: muted";
          device = "default";
          mixer = "Master";
          mixer_idx = 0;
        };
      };

      "disk /" = {
        position = 2;
        
        settings = {
          format = "ROOT: %avail";
          prefix_type = "custom";
          low_threshold = 20;
          threshold_type = "percent_avail";
        };
      };

      "cpu_usage" = {
        position = 3;
        settings.format = "CPU USAGE: %usage";
      };

      "tztime local" = {
        position = 100;
        settings.format = "%B, %e: %H:%M:%S";
      };
    };
  };
}
