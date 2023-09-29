# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, lib, pkgs, ... }:
{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  nixpkgs.config = {
    # Allow non foss packages
    allowUnfree = true;

    # Accept NVida license like whaaaaaaaaat
    nvidia.acceptLicense = true;
  };

  # Boot settings
  boot = {
    # Boot loader settings
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Required wifi driver
    extraModulePackages = [ config.boot.kernelPackages.rtl8814au ];

    # Add ntfs support
    supportedFilesystems = [ "ntfs" ];
  };

  # Network settings
  networking = {
    hostName = "funkyegg-pc";

    wireless.iwd.enable = true;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  # AEST/AEDT Timezone
  time.timeZone = "Australia/Sydney";

  # Locale settings
  i18n.defaultLocale = "en_US.UTF-8";

  # X11 Stuff
  services = {
    # OpenRGB service
    hardware.openrgb.enable = true;

    # Flatpak
    flatpak.enable = true;

    # Xserver stuff
    xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      videoDrivers = [ "nvidia" ];

      # Mouse stuff
      libinput = {
        enable = true;
        mouse = {
          accelSpeed = "0";
          accelProfile = "flat";
          tappingDragLock = false;
          tapping = false;
        };
      };

      # Enable sddm And i3wm
      displayManager = {
        sddm.enable = true;
        defaultSession = "none+i3";
      };


      # i3wm stuff
      windowManager.i3 = {
        enable = true;

        # i3wm packages
        extraPackages = with pkgs; [
          picom
          nitrogen
          
          dmenu
          i3status
          i3lock
          
          gnome.adwaita-icon-theme
          gnome.gnome-themes-extra
        ];
      };
        
      # KB Stuff
      layout = "us";
      xkbVariant = "";
    };

    udisks2.enable = true;
    gvfs.enable = true;
  };
    
  # Enable sound.
  sound.enable = true;

  # Hardware settings
  hardware = { 
    pulseaudio.enable = true;

    nvidia = {
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    
    # Openrazer settings
    openrazer = {
      enable = true;
      users = [ "funky" ];
    };

    # OpenGL stuff
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  # Setup my user
  users.users.funky = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Home manager stuff for my user
  home-manager.users.funky = {
    # Allow non foss packages
    nixpkgs.config.allowUnfree = true;

    # Home stuff
    home = {
      # Don't touch
      stateVersion = "23.11";

      # Env vars
      sessionVariables = {
        EDITOR = "hx";
        SUDO_EDITOR = "hx";
        TERMINAL = "kitty";
      };

      # Packages to install
      packages = with pkgs; [
        # GUI Apps
        firefox
        discord
        bitwarden
        spotify
        gimp
        obsidian
        vscode
        obs-studio

        # Thunar
        xfce.thunar
        xfce.thunar-volman

        # Gaming stuff
        flatpak
        lutris
        wine
        gamemode
        mangohud
        protonup-qt
        protontricks
        prismlauncher
      
        # Dev stack
        kitty
        zellij
        helix
        ols
        zls

        # Misc apps
        curl
        htop
        git
        gh
        tokei
        mpv
        flameshot
        
        # Audio stuff
        pavucontrol
        noisetorch

        # Waydroid stuff
        weston
        waydroid
      
        # Misc services
        openrgb
        dconf
        razergenie
      ];

      file = {
        # i3 + picom
        ".config/i3/config".source = .config/i3/config;
        ".config/i3status/config".source = .config/i3status/config;
        ".config/picom/picom.conf".source = .config/picom/picom.conf;
        
        # GTK
        ".config/gtk-3.0/settings.ini".source = .config/gtk-3.0/settings.ini;
        ".config/gtk-4.0/settings.ini".source = .config/gtk-4.0/settings.ini;

        # Files
        "wallpapers/firewatch.jpg".source = wallpapers/firewatch.jpg;
        
        # Misc configs
        ".config/helix/config.toml".source = .config/helix/config.toml;
        ".config/Code/User/settings.json".source = .config/Code/User/settings.json;
        ".bashrc".source = ./.bashrc;
      };
    };
  };

  # Non home manager configs
  programs = {
    noisetorch.enable = true;
    dconf.enable = true;
  };

  # Font settings
  fonts.packages = with pkgs; [ cascadia-code ];

  # xdg stuff
  xdg = { 
    mime.defaultApplications = {
      "application/pdf" = "firefox.desktop";
	    "inode/directory" = "thunar.desktop";
    };

    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };

  # Allow waydoird to virtualize
  virtualisation.waydroid.enable = true;

  # Disbale firewall
  networking.firewall.enable = false;

  # Don't touch
  system.stateVersion = "23.11";
}

