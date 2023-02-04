(define dbus
  (make <service>
    #:provides '(dbus)
    #:start (make-forkexec-constructor
             (list "dbus-daemon" "--session" "--nofork"
                   "--address" (getenv "DBUS_SESSION_BUS_ADDRESS"))
             ;; Find a way to not hard code this variable. It is set after starting the compositor...
             #:environment-variables (append (list "WAYLAND_DISPLAY=wayland-1") (environ)))
    #:stop (make-kill-destructor)))

(register-services dbus)
