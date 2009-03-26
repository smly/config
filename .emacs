;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

; detect OS
(defvar run-unix
  (or (equal system-type 'gnu/linux)
      (or (equal system-type 'usg-unix-v)
          (or  (equal system-type 'berkeley-unix)
               (equal system-type 'cygwin)))))

(defvar run-linux
  (equal system-type 'gnu/linux))
(defvar run-system-v
  (equal system-type 'usg-unix-v))
(defvar run-bsd
  (equal system-type 'berkeley-unix))
(defvar run-cygwin
  (equal system-type 'cygwin))

(defvar run-w32
  (and (null run-unix)
       (or (equal system-type 'windows-nt)
           (equal system-type 'ms-dos))))

(defvar run-darwin (equal system-type 'darwin))

;; load-path
(defun add-to-load-path (&rest paths)
  (mapc '(lambda (path)
           (add-to-list 'load-path path))
        (mapcar 'expand-file-name paths)))

(add-to-load-path "~/.emacs.d/elisp"
                  "~/.emacs.d/conf"
                  "~/lib/elisp")

;; eval-safe
;; http://www.sodan.org/~knagano/emacs/dotemacs.html#eval-safe
(defmacro eval-safe (&rest body)
  `(condition-case err
       (progn ,@body)
     (error (message "[eval-safe] %s" err))))

(eval-when-compile
  (require 'cl))

;; no bar
(tool-bar-mode nil)
(menu-bar-mode nil)
(set-scroll-bar-mode nil)

;; no bell
;; (setq visible-bell t)
(setq ring-bell-function 'ignore)

;; ;; set global
;; ;(load "term/bobcat")
(global-set-key [delete] 'delete-char)
(global-set-key [backspace] 'delete-backward-char)
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-o" 'next-multiframe-window)

;; no tab
(setq-default indent-tabs-mode nil)

;; colored space
(defface my-face-b-1 '((t (:background "medium aquamarine"))) nil)
(defface my-face-b-1 '((t (:background "dark turquoise"))) nil)
(defface my-face-b-2 '((t (:background "cyan"))) nil)
(defface my-face-b-2 '((t (:background "SeaGreen"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
    (font-lock-add-keywords
        major-mode
            '(
                ("　" 0 my-face-b-1 append)
                ("\t" 0 my-face-b-2 append)
                ("[ ]+$" 0 my-face-u-1 append)
    )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks '(lambda ()
    (if font-lock-mode
        nil
    (font-lock-mode t))))

;; show paren, line, column
(show-paren-mode 1)
(line-number-mode t)
(column-number-mode t)

;; display time
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time)

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

; req
(require 'flymake)
(require 'smart-compile)

; smart-compile
(defvar smart-compile-alist '(
  ("\\.c\\'"          . "gcc %f -lm -o %n")
  ("\\.[Cc]+[Pp]*\\'" . "g++ %f -lm -o %n")
  ("\\.java\\'"       . "javac %f")
  ("\\.f90\\'"        . "f90 %f -o %n")
  ("\\.[Ff]\\'"       . "f77 %f -o %n")
  ("\\.tex\\'"        . (tex-file))
  ("\\.pl\\'"         . "perl -cw %f")
  (emacs-lisp-mode    . (emacs-lisp-byte-compile))
) "...")

(global-set-key "\C-cc" 'smart-compile)

;; load
(load "init-color")
(load "init-haskell")
(load "init-c++")
(load "init-skk")
(load "init-sdic")
(load "init-gitit")
