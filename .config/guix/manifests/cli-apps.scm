(specifications->manifest
 '(
   ;; Terminal emulators
   "alacritty"
   "kitty"

   ;; Utilities
   "unzip"
   "openssh"
   "ripgrep"
   "neofetch"
   "curl"
   "ncurses"
   "file"
   "make"
   "qemu"

   ;; Text editors
   "vim"

   ;; Others
   "flatpak"
   "xdg-utils"      ;; For xdg-open, etc
   "xdg-dbus-proxy" ;; For Flatpak

   ;; Version control
   "git"
   "stow"

   ;; Keys
   "pinentry" ;; This should only be needed for use outside emacs
   "keychain"

   ;; NOTE: more info on https://guix.gnu.org/manual/en/html_node/Search-Paths.html
   ;; Enable man pages for the profile
   "man-db"
   ;; Enable info pages for the profile
   "info-reader"
   ))
