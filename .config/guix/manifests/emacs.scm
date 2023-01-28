(use-modules (guix transformations))

(define transform1
  (options->transformation
    '((with-commit . "emacs-geiser-guile=0.23.2")
      (with-commit . "emacs-geiser=0.23.2"))))

(packages->manifest
  (list (transform1
          (specification->package "emacs-geiser"))
        (transform1
          (specification->package "emacs-geiser-guile"))
        (transform1
          (specification->package "emacs"))
        (transform1
          (specification->package "emacs-guix"))
        (transform1
         (specification->package "emacs-vterm"))
        (specification->package "fish")))
