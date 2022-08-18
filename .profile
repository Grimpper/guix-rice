# We're in Emacs, yo
export VISUAL=emacsclient
export EDITOR="$VISUAL"
export BROWSER=firefox

# Add scripts to path
export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$HOME/.emacs.d/bin
export PATH=$PATH:$HOME/.vnode/bin

# Load installed profiles
. $HOME/.bin/pollute.sh

# Add new package declaration directory
export GUIX_PACKAGE_PATH=$HOME/guix-packages

# MPD daemon start (if no other user instance exists)
# [ ! -s ~/.config/mpd/pid ] && mpd
