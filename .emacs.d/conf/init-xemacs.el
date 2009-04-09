;; font
(cond (window-system
       (set-default-font
        "-*-fixed-medium-r-normal--12-*-*-*-*-*-*-*")
       (progn
         (set-face-font 'default
                        ;"-shinonome-gothic-medium-r-normal--12-*-*-*-*-*-*-*")
                        "-mplus-gothic-medium-r-normal--12-*-*-*-*-*-*-*")
         (set-face-font 'bold
                        ;"-shinonome-gothic-bold-r-normal--12-*-*-*-*-*-*-*")
                        "-mplus-gothic-bold-r-normal--12-*-*-*-*-*-*-*")
         (set-face-font 'italic
                        ;"-shinonome-gothic-medium-i-normal--12-*-*-*-*-*-*-*")
                        "-mplus-gothic-medium-r-normal--12-*-*-*-*-*-*-*")
         (set-face-font 'bold-italic
                        ;"-shinonome-gothic-bold-i-normal--12-*-*-*-*-*-*-*")
                        "-mplus-gothic-bold-r-normal--12-*-*-*-*-*-*-*")
       )))
