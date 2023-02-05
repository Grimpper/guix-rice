(define gpg-agent
  (make <service>
    #:provides '(gpg-agent)
    #:start (make-system-constructor "gpg-agent --daemon --enable-ssh-support")
    #:stop (make-system-destructor "gpg-connect-agent killagent /bye")))

(register-services gpg-agent)
