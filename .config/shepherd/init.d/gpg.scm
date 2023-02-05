(define gpg-agent
  (make <service>
    #:provides '(gpg-agent)
    #:start (make-system-constructor "gpg-agent --daemon --enable-ssh-support")
    #:stop (make-system-destructor "gpg-connect-agent killagent /bye")))

;; Setting the variable here will only make it availeable for the shepeherd process. Not desired.
;; (use-modules (ice-9 popen)
;;              (ice-9 rdelim))

;; (define gpg-agent
;;   (make <service>
;;     #:provides '(gpg-agent)
;;     #:start
;;     (lambda args
;;       (begin
;;         (zero? (status:exit-val (system "gpg-agent --daemon --enable-ssh-support")))
;;         (setenv "SSH_AUTH_SOCK" (read-delimited "\n" (open-input-pipe "gpgconf --list-dirs agent-ssh-socket")))))
;;     #:stop
;;     (make-system-destructor "gpgconf --kill gpg-agent")))

(register-services gpg-agent)
