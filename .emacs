;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; load-path
(defun add-to-load-path (&rest paths)
  (mapc '(lambda (path)
           (add-to-list 'load-path path))
        (mapcar 'expand-file-name paths)))

(add-to-load-path "~/.emacs.d/elisp"
                  "~/.emacs.d/conf")

;; load
(load "init-general")
(load "init-xemacs")
(load "init-color")
;(load "init-ess") ; eamcs speaks statistics
;(load "init-skk")
(load "init-sdic")
(load "init-gitit") ; (markdown, git)
(load "init-yatex")
(load "init-template")
(load "init-haskell")
(load "init-python")
(load "init-ruby")
(load "init-c++")
(load "init-prolog")
;(load "init-w3m")
(load "init-switch")
;(load "poj-mode")
;(setq poj-usrid "smly")
