(define-module (grimpper)
  #:use-module (base-system)
  #:use-module (gnu))

(operating-system
 (inherit base-operating-system)
 (keyboard-layout (keyboard-layout "us" "altgr-intl"))
 (host-name "grim-guix")
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
      (list (specification->package "sway")
            (specification->package "nss-certs")
            (specification->package "nix"))
          %base-packages))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "0a1981a1-22a8-4fcf-8423-f0e6ef4e25c0")))))
  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "8D3A-9991"
                                       'fat32))
                         (type "vfat"))
                       (file-system
                         (mount-point "/")
                         (device (uuid
                                  "d74153e8-861e-49fd-847d-4b74a523e591"
                                  'ext4))
                         (type "ext4"))
                       (file-system
                         (mount-point "/home")
                         (device (uuid
                                  "bbce9d07-1ea6-4073-abdf-63cb029fe082"
                                  'ext4))
                         (type "ext4")) %base-file-systems)))
