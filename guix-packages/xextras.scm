(define-module (xextras)
  #:use-module (guix utils)
  #:use-module (guix packages)
  #:use-module (guix licenses)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages lua)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages image)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages freedesktop))

(define-public xwinwrap
  (package
    (name "xwinwrap")
    (version "0.0.6")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ujjwal96/xwinwrap.git")
             (commit "ec32e9b72539de7e1553a4f70345166107b431f7")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0l3ng6w8jl9mryk5nx61qpd1bv5yqm7cnwy2s3vcy88n04ggbap9"))))
    (build-system gnu-build-system)
    (inputs
     (list libx11
           libxrender
           libxext))
    (arguments
     '(#:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'fix-hardcoded-paths
           (lambda _
             (substitute* "Makefile"
               (("/usr/local") %output))))
         (delete 'configure)
         (delete 'check)
         (add-before 'install 'create-missing-dirs
           (lambda _
             (mkdir-p (string-append %output "/bin")))))))
    (home-page "https://github.com/ujjwal96/xwinwrap.git")
    (synopsis "Xwinwrap allows you to stick most
of the apps to your desktop background.")
    (description "Fork of xwinwrap. Xwinwrap allows you to stick most
of the apps to your desktop background.")
    (license gpl3+)))

(define-public awesome-gtk
  (package
    (inherit awesome)
    (name "awesome-gtk")
    (inputs
     (list cairo
           dbus
           gdk-pixbuf
           glib
           gobject-introspection
           imlib2
           libev
           libxcb
           libxcursor
           libxdg-basedir
           libxkbcommon
           lua
           lua-lgi
           pango
           startup-notification
           xcb-util
           xcb-util-cursor
           xcb-util-image
           xcb-util-keysyms
           xcb-util-renderutil
           xcb-util-xrm
           xcb-util-wm
           gtk
           atk))
    (description "Variant of awesome including gtk support")))
