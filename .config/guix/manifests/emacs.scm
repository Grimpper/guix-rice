(use-modules (guix transformations))

(define transform1
  (options->transformation
    '((with-commit
        .
        "emacs-geiser-guile=0.23.2")
      (with-commit
        .
        "emacs-geiser=0.23.2"))))

(packages->manifest
  (list (transform1
          (specification->package "emacs-geiser"))
        (transform1
          (specification->package "emacs-geiser-guile"))
        (transform1 (specification->package "emacs"))
        (transform1
          (specification->package "emacs-guix"))
        (transform1
          (specification->package "emacs-vterm"))))

;; (use-modules (guix transformations))

;; ((options->transformation '((with-commit . "emacs-geiser=bc0dde310492de733f9ec528d7aeddd57093d05e")
;;                             (with-commit . "emacs-geiser-guile=c641fcc50b6b86ca95743122b5206cdcd475f96e")))
;;  (specifications->manifest
;;   '(
;;     "emacs"
;;     "emacs-vterm"
;;     "emacs-guix"
;;     "emacs-geiser"
;;     "emacs-geiser-guile"

;;     ;; Enable man pages for the profile
;;     "man-db")))
