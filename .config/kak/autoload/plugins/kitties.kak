# Source: https://github.com/FunkyEgg/dotfiles/.config/kak/autoload/plugins/kitties.kak
# Kitty terminal stuff

define-command quick-kit -params 1.. %{
    %sh{ kitty $@ }
}
