;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu)
             (gnu services)
             (gnu services sddm)
             (gnu packages xorg)
             (nongnu packages linux)
             (nongnu packages nvidia)
             (guix transformations))
(use-service-modules
  cups
  desktop
  networking
  ssh
  xorg
  linux)

(use-package-modules linux)

(define transform
  (options->transformation
   '((with-graft . "mesa=nvda"))))

(operating-system
  (kernel linux-lts)
  (kernel-arguments (append
                     '("modprobe.blacklist=nouveau")
                     %default-kernel-arguments))
  (kernel-loadable-modules (list nvidia-driver))
  (firmware (list linux-firmware))
  (locale "en_US.utf8")
  (timezone "Europe/Madrid")
  (keyboard-layout (keyboard-layout "us" "intl"))
  (host-name "grim")
  (users (cons* (user-account
                  (name "grim")
                  (comment "Grimpper")
                  (group "users")
                  (home-directory "/home/grim")
                  (supplementary-groups
                    '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))
  (packages
    (append
      (list (specification->package "bspwm")
            (specification->package "alacritty")
            (specification->package "emacs")
            (specification->package "emacs-vterm")
            (specification->package "emacs-exwm")
            (specification->package
              "emacs-desktop-environment")
            (specification->package "nss-certs"))
      %base-packages))
  (services 
    (cons* (pam-limits-service
            (list
             (pam-limits-entry "*" 'hard 'nofile 524288)))
           (simple-service
            'custom-udev-rules udev-service-type
            (list nvidia-driver))
           (service kernel-module-loader-service-type
                    '("ipmi_devintf"
                      "nvidia"
                      "nvidia_modset"
                      "nvidia_uvm"))
           (service sddm-service-type
            (sddm-configuration
              (display-server "wayland")
              (remember-last-user? #t)
              (themes-directory "/opt/sddm")
              (theme "sugar-candy")
              (xorg-configuration (xorg-configuration
                                   (modules (cons* nvidia-driver %default-xorg-modules))
                                   (server (transform xorg-server))
                                   (drivers '("nvidia"))))))
           (service gnome-desktop-service-type)
           (modify-services %desktop-services
                            (delete gdm-service-type)
                            ;; (guix-service-type config =>
                            ;;                    (guix-configuration
                            ;;                     (inherit config)
                            ;;                     (substitute-urls (append (list "https://substitutes.guix.psychnotebook.org")
                            ;;                                              %default-substitute-urls))
                            ;;                     (authorized-keys (append (list (local-file "substitutes/psychnotebook.pub"))
                            ;;                                       %default-authorized-guix-keys))))
                            )))
  (bootloader
    (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (targets (list "/boot/efi"))
      (keyboard-layout keyboard-layout)))
  (file-systems
    (cons* (file-system
             (mount-point "/home")
             (device
               (uuid "9674545f-78dc-44c9-bd63-0da85ed699df"
                     'ext4))
             (type "ext4"))
           (file-system
             (mount-point "/")
             (device
               (uuid "2c12513d-e7ee-4fe8-80d2-e7399f8e437c"
                     'ext4))
             (type "ext4"))
           (file-system
             (mount-point "/boot/efi")
             (device (uuid "ED98-F9EC" 'fat32))
             (type "vfat"))
           %base-file-systems)))
