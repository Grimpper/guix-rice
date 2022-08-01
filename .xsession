#!/bin/sh

# Make Flatpak apps visible to launcher
export XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share"

export GUIX_EXTRA_PROFILES=$HOME/.guix-extra-profiles
export GUIX_MANIFESTS=$HOME/.config/guix/manifests

# Load the default Guix profile
GUIX_PROFILE="$HOME/.guix-profile"
. "$GUIX_PROFILE"/etc/profile

# Load installed profiles
. $HOME/.bin/pollute.sh

# Ensure that font folders are loaded correctly
xset +fp $(dirname $(readlink -f $GUIX_EXTRA_PROFILES/fonts/fonts/share/fonts/truetype/fonts.dir))

# Disable access control for the current user
xhost +SI:localuser:$USER

# Make Java applications aware this is a non-reparenting window manager
export _JAVA_AWT_WM_NONREPARENTING=1

# Start Shepherd to manage user daemons
if [ -z "$(pgrep -u grim shepherd)" ]; then
  shepherd
fi

# Run xsettingsd to propagate font and theme settings
xsettingsd &

# Enable screen compositing
# compton &

# Turn off the system bell
xset -b

# Enable screen locking on suspend
xss-lock -- slock &

# Uncomment this to start xterm instead for debugging purposes!
# Then you can manually run the window manager and log output
# > exec dbus-launch emacs -mm --debug-init --use-exwm 2>&1 | tee ~/debug.log
#xterm

xrandr
xrdb -merge ~/.Xresources

# Fire it up
exec bspwm
