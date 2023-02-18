(define-module (display-managers)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix build-system trivial)
  #:use-module ((guix licenses) #:prefix license:))

(define-public sddm-dexy-color
  (package
    (name "sddm-dexy-color")
    (version "0.0.1")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/L4ki/Dexy-Plasma-Themes")
                    (commit "7929384dbb9305e6da53a8942bca3d75593fd99f")))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1dcp3pvs6x63740sz852yr19fjrdnh81dbrq7rssgm6ssi1rqjig"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let* ((out (assoc-ref %outputs "out"))
                (sddm-themes (string-append out "/share/sddm/themes")))
           (mkdir-p sddm-themes)
           (copy-recursively (string-append (assoc-ref %build-inputs "source") "/Dexy-Color-SDDM")
                             (string-append sddm-themes "/dexy-color"))))))
    (home-page "https://github.com/L4ki/Dexy-Plasma-Themes")
    (synopsis "Dexy Color theme for SDDM")
    (description "Dexy-Color-SDDM is part of KDE Themes and Extensions.")
    (license license:gpl3+)))

(define-public sddm-abstract
  (package
    (name "sddm-abstract")
    (version "0.0.1")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/3ximus/abstractdark-sddm-theme")
                    (commit "e817d4b27981080cd3b398fe928619ffa16c52e7")))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1si141hnp4lr43q36mbl3anlx0a81r8nqlahz3n3l7zmrxb56s2y"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let* ((out (assoc-ref %outputs "out"))
                (sddm-themes (string-append out "/share/sddm/themes")))
           (mkdir-p sddm-themes)
           (copy-recursively (assoc-ref %build-inputs "source")
                             (string-append sddm-themes "/abstract"))))))
    (home-page "https://github.com/3ximus/abstractdark-sddm-theme")
    (synopsis "Abstract Dark theme for SDDM")
    (description "Abstract Dark theme for SDDM")
    (license license:gpl3+)))

;; TODO Find a way to install qtmultimedia dependency
;; (define-public sddm-delicious
;;   (package
;;     (name "sddm-delicious")
;;     (version "0.0.1")
;;     (source (origin
;;               (method git-fetch)
;;               (uri (git-reference
;;                     (url "https://github.com/stuomas/delicious-sddm-theme")
;;                     (commit "fc98a56db6a61521cb2c55f2c50416f01f565ef7")))
;;               (file-name (git-file-name name version))
;;               (sha256
;;                (base32
;;                 "085n7663p0bz6jl516z7gvkc09m2rr33cygpl3n3fnyg3ins7msw"))))
;;     (build-system trivial-build-system)
;;     (arguments
;;      `(#:modules ((guix build utils))
;;        #:builder
;;        (begin
;;          (use-modules (guix build utils))
;;          (let* ((out (assoc-ref %outputs "out"))
;;                 (sddm-themes (string-append out "/share/sddm/themes")))
;;            (mkdir-p sddm-themes)
;;            (copy-recursively (assoc-ref %build-inputs "source")
;;                              (string-append sddm-themes "/delicious"))))))
;;     (home-page "https://github.com/stuomas/delicious-sddm-theme")
;;     (synopsis "A delicious SDDM theme for DE collectors/addicts")
;;     (description "Delicious wants to showcase the available sessions instead of available users as in most cases there is only one user, although the user can of course still be changed in the menu in the footer panel.")
;;     (license license:gpl3+)))
