(define-module (grimpper)
  #:use-module (gnu)
  #:use-module (base-system)
  #:use-module (nongnu packages linux))

(use-service-modules linux
                     nix)

(operating-system
  (inherit base-operating-system)
  (kernel linux-lts)
  (kernel-arguments
   (cons* "resume=/swapfile"
          "resume_offset=92514304"
          %default-kernel-arguments))
  (firmware (list linux-firmware))
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
  (services (append (list (service nix-service-type))
                    %base-operating-system-services))
  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
               (targets (list "/boot/efi"))
               (keyboard-layout %base-operating-system-keyboard)
               (menu-entries (list
                              (menu-entry (label "Pop_OS!")
                                          (linux "/boot/vmlinuz")
                                          (linux-arguments '("root=/dev/nvme0n1p5"))
                                          (initrd "/boot/initrd.img"))))))
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
                         (type "ext4")) %base-file-systems))
  ;; The swap file need to be created manually?
  ;; $ sudo dd if=/dev/zero of=/swapfile bs=1024 count=16777216
  ;; $ sudo chmod 0600 /swapfile
  ;; $ sudo mkswap /swapfile
  (swap-devices
   (list
    (swap-space
     (target "/swapfile")
     (dependencies (filter (file-system-mount-point-predicate "/")
                           file-systems))))))
