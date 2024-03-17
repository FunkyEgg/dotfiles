# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

PS1='[\u@\H]<\w>\n\$ '
PS2='=> '

# alias updatenix='sudo nix-channel --update'
# alias upgradenix='sudo nix-channel --update && sudo nixos-rebuild switch'
# alias rebuildnix='sudo nixos-rebuild switch'
# alias cleanupnix='sudo nix-env --delete-generations old && sudo nix-store --gc && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot'
# alias editnix='code /etc/nixos'

alias enterdev='cd /home/funky/mnt/devel/'
# alias mountd='udisksctl mount -b /dev/disk/by-label/games && udisksctl mount -b /dev/disk/by-label/devel && udisksctl mount -b /dev/disk/by-label/butter'

alias screenkey='screenkey -t 0.7 -s small'
# . "$HOME/.cargo/env"
