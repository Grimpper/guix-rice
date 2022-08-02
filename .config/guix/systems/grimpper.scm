(define-module (grimpper)
  #:use-module (base-system)
  #:use-module (gnu))

(operating-system
 (inherit base-operating-system)
 (host-name "grim")
 (users (cons* (user-account
                (name "grim")
                (comment "Grimpper")
                (group "users")
                (home-directory "/home/grim")
                (supplementary-groups
                 '("wheel" "netdev" "audio" "video")))
               %base-user-accounts))
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
