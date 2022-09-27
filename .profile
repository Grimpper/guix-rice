# We're in Emacs, yo
export VISUAL=emacsclient
export EDITOR="$VISUAL"
export BROWSER=chromium

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

export XCURSOR_PATH=$XCURSOR_PATH:$GUIX_EXTRA_PROFILES/desktop/desktop/share/icons

# GTK
export GTK_THEME=Dracula

# Make Java applications aware this is a non-reparenting window manager
export _JAVA_AWT_WM_NONREPARENTING=1
# export SDL_VIDEODRIVER=wayland
# export QT_QPA_PLATFORM=wayland
# export XDG_CURRENT_DESKTOP=sway
# export XDG_SESSION_DESKTOP=sway

# Start Shepherd to manage user daemons
if [ -z "$(pgrep -u grim shepherd)" ]; then
  shepherd
fi
