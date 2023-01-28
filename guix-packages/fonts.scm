(define-module (fonts)
  #:use-module ((gnu packages autotools) #:select (autoconf automake))
  #:use-module ((gnu packages tex) #:select (texlive-bin))
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system font)
  #:use-module ((guix build-system gnu) #:select (gnu-build-system)))

(define-public font-nerd-fonts
  (package
    (name "font-nerd-fonts")
    (version "2.1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ryanoasis/nerd-fonts")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1la79y16k9rwcl2zsxk73c0kgdms2ma43kpjfqnq5jlbfdj0niwg"))))
    (build-system font-build-system)
    (home-page "https://www.nerdfonts.com/")
    (synopsis "Iconic font aggregator, collection, and patcher")
    (description
     "Nerd Fonts patches developer targeted fonts with a high number
of glyphs (icons). Specifically to add a high number of extra glyphs
from popular ‘iconic fonts’ such as Font Awesome, Devicons, Octicons,
and others.")
    (license license:expat)))

(define-public font-font-awesome
  (package
    (name "font-font-awesome")
    (version "5.11.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/FortAwesome/Font-Awesome")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0ya14lgx5mgpjbnw6sss3a2c99n6cw6xryd0xj8rbjwbr2gmrf1q"))))
    (build-system font-build-system)
    (home-page "https://fontawesome.com")
    (synopsis "The iconic SVG, font, and CSS toolkit")
    (description
     "The internet's most popular icon toolkit has been redesigned and
built from scratch. On top of this, features like icon font ligatures,
an SVG framework, official NPM packages for popular frontend libraries
like React, and access to a new CDN.")
    (license #f)))

(define-public font-et-book
  (package
   (name "font-et-book")
   (version "1.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/edwardtufte/et-book")
           (commit "24d3a3bbfc880095d3df2b9e9d60d05819138e89")))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "1bhpk1fbp8jdhzc5j8y5v3bpnzy2sz3dpgjgzclb0dnm51hqqrpn"))))
    (build-system font-build-system)
    (home-page "https://edwardtufte.github.io/et-book/")
    (synopsis "ET Book fonts")
    (description
     "ET Book is a Bembo-like font for the computer designed by Dmitry Krasny, Bonnie Scranton, and Edward Tufte. It is free and open-source.")
    (license license:expat)))

(define-public font-powerline
  (package
   (name "font-powerline")
   (version "1.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/powerline/fonts")
           (commit "e80e3eba9091dac0655a0a77472e10f53e754bb0")))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "0n8yhc8y1vpiyza58d4fj5lyf03ncymrxc81a31crlbzlqvwwrqq"))))
    (build-system font-build-system)
    (home-page "https://powerline.readthedocs.io/en/latest/installation/linux.html#fonts-installation")
    (synopsis "Powerline fonts")
    (description "Patched fonts for Powerline users.")
    (license license:expat)))

(define-public font-iosevka-comfy
  (package
   (name "font-iosevka-comfy")
   (version "1.1.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/protesilaos/iosevka-comfy")
           (commit version)))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "1h72my1s9pvxww6yijrvhy7hj9dspnshya60i60p1wlzr6d18v3p"))))
    (build-system font-build-system)
    (home-page "https://protesilaos.com/codelog/2022-10-19-iosevka-comfy-1-1-0/")
    (synopsis "Custom version of Iosevky by Protesilaos Stavrou")
    (description "Iosevka Comfy is a customised build of the Iosevka typeface, with a consistent rounded style and overrides for almost all individual glyphs in both roman (upright) and italic (slanted) variants.")
    (license license:silofl1.1)))
