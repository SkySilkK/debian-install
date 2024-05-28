#SET options for sway
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland

#SET path to cargo and cargo apps
export PATH=$PATH:$HOME/.cargo/bin/
. "$HOME/.cargo/env"

#Acess neovim installed via bob
export PATH=$PATH:$HOME/.local/share/bob/nvim-bin

#SET UTF-8 for tmux-icons, shell and btop
export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8



# Created by `pipx` on 2024-05-28 06:26:44
export PATH="$PATH:$HOME/.local/bin"

alias ls="eza --icons"
