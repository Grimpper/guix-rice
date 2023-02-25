(specifications->manifest
 '(
   ;; Emacs packages
   "emacs-next-pgtk"
   "emacs-guix"
   "emacs-company" ;; Needed as completion framework for `emacs-guix'
   "emacs-geiser"
   "emacs-geiser-guile"
   "emacs-vterm"

   ;; External dependencies
   "python"
   "dtach"
   "direnv"
   "fish"
   "ripgrep"
   "git"

   ;; NOTE: more info on https://guix.gnu.org/manual/en/html_node/Search-Paths.html
   ;; Enable man pages for the profile
   "man-db"
   ;; Enable info pages for the profile
   "info-reader"
   ))
