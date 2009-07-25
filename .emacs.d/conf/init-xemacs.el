;; font
(cond (window-system
       (set-default-font
        "-*-sys-medium-r-normal--10-*-*-*-*-*-*-*")
;        "-mplus-gothic-medium-r-normal--10-*-*-*-*-*-*-*")
;;        (progn
;;          (set-face-font 'default
;;                         ;"-shinonome-gothic-medium-r-normal--12-*-*-*-*-*-*-*")
;;                         "-mplus-gothic-medium-r-normal--10-*-*-*-*-*-*-*")
;;          (set-face-font 'bold
;;                         ;"-shinonome-gothic-bold-r-normal--12-*-*-*-*-*-*-*")
;;                         "-mplus-gothic-bold-r-normal--10-*-*-*-*-*-*-*")
;;          (set-face-font 'italic
;;                         ;"-shinonome-gothic-medium-i-normal--12-*-*-*-*-*-*-*")
;;                         "-mplus-gothic-medium-r-normal--10-*-*-*-*-*-*-*")
;;          (set-face-font 'bold-italic
;;                         ;"-shinonome-gothic-bold-i-normal--12-*-*-*-*-*-*-*")
;;                         "-mplus-gothic-bold-r-normal--10-*-*-*-*-*-*-*")
;;        )))
))

; linum
(require 'linum)
(global-linum-mode 1)
(setq linum-format
      (lambda (line)
        (propertize (format
                     (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
                       (concat "%" (number-to-string w) "d "))
                     line) 'face 'linum)))
