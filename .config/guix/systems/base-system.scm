(define-module (base-system)
  #:use-module (gnu)
  #:use-module (gnu services sddm))

(use-service-modules
 desktop
 xorg)

(define-public %base-operating-system-keyboard
  (keyboard-layout "us" "altgr-intl"))

(define-public %base-operating-system-services
  (cons* (pam-limits-service
          (list
           (pam-limits-entry "*" 'hard 'nofile 524288)))
         (service sddm-service-type
                  (sddm-configuration
                   (display-server "wayland")
                   (remember-last-user? #t)
                   (themes-directory "/opt/sddm")
                   (theme "sugar-candy")))
         (modify-services %desktop-services
           (delete gdm-service-type))))

(define-public base-operating-system
  (operating-system
    (locale "en_US.utf8")
    (timezone "Europe/Madrid")
    (keyboard-layout %base-operating-system-keyboard)
    (host-name "dummypc")
    (users (cons* (user-account
                   (name "dummy")
                   (comment "Dummy")
                   (group "users")
                   (home-directory "/home/dummy")
                   (supplementary-groups
                    '("wheel" "netdev" "audio" "video")))
                  %base-user-accounts))
    (services base-operating-system-services)
    (bootloader
     (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (targets (list "/boot/efi"))
      (keyboard-layout %base-operating-system-keyboard)))
    ;; Guix doesn't like it when there isn't a file-systems
    ;; entry, so add one that is meant to be overridden
    (file-systems (cons*
                   (file-system
                     (mount-point "/tmp")
                     (device "none")
                     (type "tmpfs")
                     (check? #f))
                   %base-file-systems))))
