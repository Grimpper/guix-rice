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

   ;; Enable man pages for the profile
   "man-db"
   ))
