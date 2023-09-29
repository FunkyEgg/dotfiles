# Bash config
{
  programs.bash = {
    enable = true;
    shellAliases = {
      rebuildnix = "sudo nixos-rebuild switch";
      cleanupnix = "sudo nix-env --delete-generations old && $ nix-store --gc";
      editnix = "code /etc/nixos";
      updatenix = "sudo nix-channel --update";
      upgradenix = "sudo nix-channel --update && sudo nixos-rebuild switch";

      # ifuckedhm = "rm -rf /home/funky/.config"

      mountd = "udisksctl mount -b /dev/disk/by-label/games && udisksctl mount -b /dev/disk/by-label/devel";
      enterdev = "cd /run/media/funky/devel/";

      screenkey = "screenkey -t 1.375 -s small";
      grep = "grep -irnH";
      
      eza = "eza -F";
      ezaa = "eza -aF";
      ezat = "eza -TF";

      steam = "flatpak run com.valvesoftware.Steam";
      flatseal = "flatpak run com.github.tchx84.Flatseal";

      rusher = "LD_LIBRARY_PATH=/nix/store/rjz12jr6wa46vcaj7v2nsi2x17jibipm-systemd-253.6/lib:$LD_LIBRARY_PATH java -jar RusherInstaller.jar";
    };
  };
}