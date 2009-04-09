;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

; avoid libedit problem
(load "~/.emacs.d/elisp/haskell-mode-2.4/haskell-site-file")

(setq haskell-program-name "~/.cabal/bin/ghci-haskeline")

(nconc auto-mode-alist
       '(("\\.[hg]s$"  . haskell-mode)
         ("\\.hsc$"    . haskell-mode)
         ("\\.hi$"     . haskell-mode)
         ("\\.l[hg]s$" . literate-haskell-mode)))
(autoload 'haskell-mode "haskell-mode"
   "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
   "Major mode for editing literate Haskell scripts." t)
(add-hook 'haskell-mode-hook 'turn-on-haskell-font-lock)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
(add-hook 'haskell-mode-hook 'font-lock-mode)

(defadvice haskell-indent-indentation-info (after haskell-indent-reverse-indentation-info)
  (when (>= (length ad-return-value) 2)
    (let ((second (nth 1 ad-return-value)))
      (setq ad-return-value (cons second (delete second ad-return-value))))))

(ad-activate 'haskell-indent-indentation-info)

; flymake-mode for haskell
(require 'flymake)
(defun flymake-Haskell-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-with-folder-structure nil nil
   (file-name-nondirectory buffer-file-name)
   'flymake-get-Haskell-cmdline))

(defun flymake-get-Haskell-cmdline (source base-dir)
  (list "flycheck_haskell.pl"
        (list source base-dir)))

(push '(".+\\.hs$" flymake-Haskell-init flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)
(push '(".+\\.lhs$" flymake-Haskell-init flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)
(push
 '("^\\(\.+\.hs\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.+\\)"
   1 2 3 4) flymake-err-line-patterns)

(add-hook 'haskell-mode-hook
          '(lambda ()
             (if (not (null buffer-file-name)) (flymake-mode))))

;; Display messages at the minibuffer
(global-set-key "\C-cd"
                'flymake-show-and-sit )
(defun flymake-show-and-sit ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (progn
    (let* ( (line-no             (flymake-current-line-no) )
            (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
            (count               (length line-err-info-list))
            )
      (while (> count 0)
        (when line-err-info-list
          (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
                 (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
                 (text (flymake-ler-text (nth (1- count) line-err-info-list)))
                 (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
            (message "[%s] %s" line text)
            )
          )
        (setq count (1- count)))))
  (sit-for 60.0)
  )
;;

;; haskell-hoogle
(add-hook 'haskell-mode-hook
          '(lambda ()
            (local-set-key "\C-ch" 'haskell-hoogle)))
