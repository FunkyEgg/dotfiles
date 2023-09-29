# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

HISTFILESIZE=100000
HISTSIZE=10000

shopt -s histappend
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

alias updatenix='sudo nix-channel --update'
alias upgradenix='sudo nix-channel --update && sudo nixos-rebuild switch'
alias rebuildnix='sudo nixos-rebuild switch'
alias cleanupnix='sudo nix-env --delete-generations old && $ nix-store --gc'
alias editnix='code /etc/nixos'

alias enterdev='cd /run/media/funky/devel/'
alias mountd='udisksctl mount -b /dev/disk/by-label/games && udisksctl mount -b /dev/disk/by-label/devel'

alias flatseal='flatpak run com.github.tchx84.Flatseal'
alias steam='flatpak run com.valvesoftware.Steam'
alias screenkey='screenkey -t 1.375 -s small'

# alias eza='eza -F'
# alias ezaa='eza -aF'
# alias ezat='eza -TF'
# alias rusher='LD_LIBRARY_PATH=/nix/store/rjz12jr6wa46vcaj7v2nsi2x17jibipm-systemd-253.6/lib:$LD_LIBRARY_PATH java -jar RusherInstaller.jar'