(define emacs-daemon
  (make <service>
    #:provides '(emacsd emacs-daemon)
    #:start (make-system-constructor "emacs --daemon")
    #:stop (make-system-destructor "emacsclient --eval \"(kill-emacs)\"")))

(register-services emacs-daemon)
