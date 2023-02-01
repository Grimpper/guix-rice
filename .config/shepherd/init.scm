(use-modules (shepherd service)
             ((ice-9 ftw) #:select (scandir)))

;; Load all the files in the directory 'init.d' with a suffix '.scm'.
(for-each
 (lambda (file)
   (load (string-append "init.d/" file)))
 (scandir (string-append (dirname (current-filename)) "/init.d")
          (lambda (file)
            (string-suffix? ".scm" file))))

;; Send shepherd into the background
(action 'shepherd 'daemonize)

;; (define dbus
;;   (make-service
;;     #:docstring "D-Bus Session Daemon"
;;     #:provides '(dbus)
;;     #:start (make-forkexec-constructor-with-env
;;              (list "dbus-daemon" "--session" "--nofork"
;;                    "--address" %dbus-address)
;;              ;; Start dbus with $DISPLAY, as dbus may start services
;;              ;; (e.g., notification daemon) that need this environment.
;;              #:display available-display)
;;     #:stop (make-kill-destructor)))

;; (register-services dbus)
