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
      exportConfiguration = true; # link /usr/share/X11/ properly

      layout = "us,us";
      xkbVariant = ",dvorak";
      xkbOptions = "grp:alt_space_toggle";
      
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
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
      setLdLibraryPath = true;
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
        obs-studio
        vscode
        protonvpn-gui
        aseprite

        # Thunar
        xfce.thunar
        xfce.thunar-volman

        # Gaming stuff
        python3 # Rotmg
        wine64Packages.stableFull
        winetricks
        dxvk
        flatpak
        gamemode
        mangohud
        protonup-qt
        protontricks
        prismlauncher
      
        # Dev stack
        kitty
        xplr
        ripgrep
        helix
        ungit
        kakoune
        neovim
        # hotspot
        # linuxPackages_latest.perf
        # valgrind
        
        # Language servers
        zls

        # Misc apps
        curl
        unzip
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
      ];

      file = {
        ".config" = {
          source = ./.config;
          recursive = true;
        };

        "wallpapers" = {
          source = ./wallpapers;
          recursive = true;
        };

        ".bashrc".source = ./.bashrc;
        ".Xdefaults".source = ./.Xdefaults; # Never commit XDefaults to git since I never use xterm se from smapi
      };
    };

    programs.helix.defaultEditor = true;
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