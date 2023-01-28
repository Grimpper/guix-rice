(define-module (base-system)
  #:use-module (gnu)
  ;; #:use-module (gnu services)
  #:use-module (gnu services sddm)
  ;; #:use-module (gnu packages xorg)
  ;; #:use-module (nongnu packages linux)
  ;; #:use-module (nongnu packages nvidia)
  ;; #:use-module (guix transformations)
  )

(use-service-modules
 cups
 desktop
 networking
 ssh
 xorg
 ;; linux
 nix)

;; (use-package-modules linux)

;; (define transform
;;   (options->transformation
;;    '((with-graft . "mesa=nvda"))))

(define-public base-operating-system
 (operating-system
  ;; (kernel linux-lts)
  ;; (kernel-arguments (append
  ;;                    '("modprobe.blacklist=nouveau")
  ;;                    %default-kernel-arguments))
  ;; (kernel-loadable-modules (list nvidia-driver))
  ;; (firmware (list linux-firmware))
  (locale "en_US.utf8")
  (timezone "Europe/Madrid")
  (keyboard-layout (keyboard-layout "us" "altgr-intl"))
  (host-name "dummypc")
  (users (cons* (user-account
                  (name "dummy")
                  (comment "Dummy")
                  (group "users")
                  (home-directory "/home/dummy")
                  (supplementary-groups
                    '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))
  (services
   (cons* (service nix-service-type)
          (pam-limits-service
           (list
            (pam-limits-entry "*" 'hard 'nofile 524288)))
          ;; (simple-service
          ;;  'custom-udev-rules udev-service-type
          ;;  (list nvidia-driver))
          ;; (service kernel-module-loader-service-type
          ;;          '("ipmi_devintf"
          ;;            "nvidia"
          ;;            "nvidia_modset"
          ;;            "nvidia_uvm"))
          (service sddm-service-type
                   (sddm-configuration
                    (display-server "wayland")
                    (remember-last-user? #t)
                    (themes-directory "/opt/sddm")
                    (theme "sugar-candy")
                    ;; (xorg-configuration (xorg-configuration
                    ;;                      (modules (cons* nvidia-driver %default-xorg-modules))
                    ;;                      (server (transform xorg-server))
                    ;;                      (drivers '("nvidia"))))
                    ))
          (modify-services %desktop-services
                           (delete gdm-service-type))))
  (bootloader
    (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (targets (list "/boot/efi"))
      (keyboard-layout keyboard-layout)))
  ;; Guix doesn't like it when there isn't a file-systems
  ;; entry, so add one that is meant to be overridden
  (file-systems (cons*
                 (file-system
                  (mount-point "/tmp")
                  (device "none")
                  (type "tmpfs")
                  (check? #f))
                 %base-file-systems))))
