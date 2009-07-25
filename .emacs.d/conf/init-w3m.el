;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(add-to-list 'load-path "~/.emacs.d/elisp/emacs-w3m")
; default
(setq browse-url-browser-function 'w3m-browse-url)

(require 'w3m-load)
(setq w3m-default-display-inline-images t)
(setq w3m-use-cookies t)
(setq w3m-follow-redirection 3)
(setq w3m-home-page "http://cl.naist.jp/")
