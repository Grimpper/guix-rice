# We're in Emacs, yo
export VISUAL=emacsclient
export EDITOR="$VISUAL"

# Add scripts to path
export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$HOME/.emacs.d/bin

# Load installed profiles
. $HOME/.bin/pollute.sh

# Export environment for Flatpak
# export $(dbus-launch)
