# We're in Emacs, yo
export VISUAL=emacsclient
export EDITOR="$VISUAL"
export BROWSER=firefox

# Add scripts to path
export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.emacs.d/bin
export PATH=$PATH:$HOME/.vnode/bin

# MPD daemon start (if no other user instance exists)
# [ ! -s ~/.config/mpd/pid ] && mpd

# Load guix environment
. $HOME/.guix-environment

# Load nix environment
. /run/current-system/profile/etc/profile.d/nix.sh

# Make Flatpak & Nix apps visible to launcher
export XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share"
export XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.nix-profile/share"

# Load installed profiles
. $HOME/.bin/pollute.sh
