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

    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
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

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # OpenRGB service
    hardware.openrgb.enable = true;

    # Flatpak
    flatpak.enable = true;

    # Xserver stuff
    xserver = {
      enable = true;
      exportConfiguration = true; # link /usr/share/X11/ properly

      # Keyboard stuff
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
    tumbler.enable = true;
  };

  # Hardware settings
  hardware = { 
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
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
      # extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
      # setLdLibraryPath = true;
    };
  };

  # Setup my user
  users.users.funky = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "fuse" "disk" ];
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
        soundux
        xfce.thunar
        dxvk
        protonup-qt
        wineWowPackages.staging
        appimage-run
        steam
        prismlauncher
        
        # Dev stack
        kakoune
        kitty
        xplr
        ripgrep
        helix
        ungit
        neovim
        gdb
        tree # Kakoune file tree
        gcc # Treesitter
         
        # Language servers
        clang-tools_16
        haskell-language-server
        zls
        gopls

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
        polychromatic
        dconf
        btrfs-progs
        xclip
        vkbasalt
        replay-sorcery
        mangohud
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

    programs = {
      obs-studio = {
        enable = true;

        plugins = with pkgs.obs-studio-plugins; [
          input-overlay
          obs-pipewire-audio-capture
        ];
      };

      helix.defaultEditor = true;
    };
  };

  # Non home manager configs
  programs = {
    gamemode.enable = true;
    noisetorch.enable = true;
    dconf.enable = true;

    thunar.plugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
    ];
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
      config.common.default = "*";

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };

  # Virtualisation stuff
  virtualisation = {
    waydroid.enable = true;
    docker.enable = true;
  };

  # Disbale firewall
  networking.firewall.enable = false;

  # Don't touch
  system.stateVersion = "23.11";
}