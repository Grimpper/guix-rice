# We're in Emacs, yo
export VISUAL=emacsclient
export EDITOR="$VISUAL"
export BROWSER=chromium

# Add scripts to path
export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.emacs.d/bin
export PATH=$PATH:$HOME/.vnode/bin

# Load guix environment
. $HOME/.guix-environment

# Load nix environment
. /run/current-system/profile/etc/profile.d/nix.sh

# Make Flatpak & Nix apps visible to launcher
export XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share"
export XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.nix-profile/share"

# Add cursor install location
export XCURSOR_PATH=$XCURSOR_PATH:$GUIX_EXTRA_PROFILES/desktop/desktop/share/icons

# GTK theme
export GTK_THEME=Arc-Dark
export GTK2_RC_FILES=$GUIX_EXTRA_PROFILES/desktop/desktop/share/themes/$GTK_THEME/gtk-2.0/gtkrc

# Dbus
export DBUS_SESSION_BUS_ADDRESS="unix:path=/tmp/dbus-$UID"

# On sway set
if [[ $DESKTOP_SESSION =~ .*/sway$ ]]; then
    # Make Java applications aware this is a non-reparenting window manager
    export _JAVA_AWT_WM_NONREPARENTING=1
    export SDL_VIDEODRIVER=wayland
    export QT_QPA_PLATFORM=wayland
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_DESKTOP=sway
fi

# Start Shepherd to manage user daemons
if [[ ! -S ${XDG_RUNTIME_DIR-$HOME/.cache}/shepherd/socket ]]; then
    # Export ssh variable after initializing the gpg ssh socket. This needs to be done here
    # since doing it in Shepherd won't export it to this parent process.
    export GPG_TTY=$(tty)
    unset SSH_AGENT_PID
    if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    fi

    shepherd
fi
