# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, lib, pkgs, ... }:
{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  # Allow non foss packages
  nixpkgs.config.allowUnfree = true;

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

  # Console font
  # console.font = "Lat2-Terminus16";

  # X11 Stuff
  services = {
    # OpenRGB service
    hardware.openrgb.enable = true;

    # Xserver stuff
    xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      videoDrivers = [ "nvidia" ];

      # Enable sddm And i3wm
      displayManager = {
        sddm.enable = true;
        defaultSession = "none+i3";
        
        sessionCommands = ''
          ${pkgs.xorg.xinput} --set-prop 'Razer Razer Basilisk V3' 'libinput Accel Speed' 0.5
        '';
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
          lounge-gtk-theme
        ];
      };
        
      # KB Stuff
      layout = "us";
      xkbVariant = "";
    };
  };
    
  # Enable sound.
  sound.enable = true;

    # Hardware settings
  hardware = { 
    pulseaudio.enable = true;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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

      sessionVariables = {
        EDITOR = "hx";
        SUDO_EDITOR = "hx";
        TERMINAL = "kitty";
      };

      # Packages to install
      packages = with pkgs; [
        firefox
        discord
        bitwarden
        spotify
        gimp
        obsidian
        vscode

        xfce.thunar
        xfce.thunar-volman

        steam
        protonup-qt
      
        kitty
        helix
        wget
        curl
        htop
        git
        
        pavucontrol
        noisetorch

        weston
        waydroid
      
        openrgb
      ];
    };

    imports = [
      # Helix config from https://github.com/FunkyEgg/dotfiles/blob/main/helix/config.toml
      # Setout how the original config was setout
      ./configs/helix.nix

      # i3wm config (also has picom and x11 stuff)
      # i3status stuff bnased off of https://github.com/andreatta/config/blob/master/i3/i3status.conf
      ./configs/i3.nix
    ];

    # Bash config
    # TODO: Move to new file because I know how big this will get
    programs.bash = {
      enable = true;
      shellAliases = {
        rebuildnix = "sudo nixos-rebuild switch";
        cleanupnix = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d";
        editnixconfighx = "sudoedit /etc/nixos/configuration.nix";
        editnixconfigcode = "sudo code /etc/nixos";
        ifuckedhm = "rm -rf /home/funky/.config";
        mountd = "udisksctl mount -b /dev/disk/by-label/games && udisksctl mount -b /dev/disk/by-label/devel";
      };
    };
  };

  # Non home manager configs
  programs = {
    noisetorch.enable = true;
    
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraLibraries = p: with p; [
          (lib.getLib networkmanager)
        ];

        extraPkgs = pkgs: with pkgs; [
          mangohud
          gamemode
        ];
      };
    };
  };

  # Allow waydoird to virtualize
  virtualisation.waydroid.enable = true;
  
  # System packages
  # environment.systemPackages = with pkgs; [];
  
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Disbale firewall
  networking.firewall.enable = false;

  # Don't touch
  system.stateVersion = "23.11";
}

