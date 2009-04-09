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
(load "init-haskell")
(load "init-c++")
(load "init-python")
(load "init-skk")
(load "init-sdic")
(load "init-gitit") ; for gitit (markdown, git)
