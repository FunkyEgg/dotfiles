alias updatenix='sudo nix-channel --update'
alias upgradenix='sudo nix-channel --update && sudo nixos-rebuild switch'
alias rebuildnix='sudo nixos-rebuild switch'
alias cleanupnix='sudo nix-env --delete-generations old && sudo nix-store --gc && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot'
alias editnix='code /etc/nixos'

alias enterdev='cd /run/media/funky/devel/'
alias mountd='udisksctl mount -b /dev/disk/by-label/games && udisksctl mount -b /dev/disk/by-label/devel && udisksctl mount -b /dev/disk/by-label/butter'

alias flatseal='flatpak run com.github.tchx84.Flatseal'
alias steam='flatpak run com.valvesoftware.Steam'
alias screenkey='screenkey -t 0.7 -s small'
alias olympus='flatpak run io.github.everestapi.Olympus'

alias slippi='/run/media/funky/games/slippi/slippi.AppImage'
alias slippid='nix run github:lytedev/ssbm-nix#slippi-netplay'

alias drawt='flitter /run/media/funky/games/flitter/draw_steam.scm'