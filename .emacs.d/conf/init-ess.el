(setq load-path (cons "/usr/share/emacs/site-lisp/ess" load-path))
(load "/usr/share/emacs/site-lisp/ess/ess-site")

(require 'ess-site)
;; (setq ess-ask-for-ess-directory nil)
;; (setq ess-pre-run-hook
;;       '((lambda ()
;;           (setq default-process-coding-system '(utf8 . utf8))
;;           )))

(defun ess:format-window-1 ()
  (split-window-horizontally)
  (other-window 1)
  (split-window)
  (other-window 1))
(add-hook 'ess-pre-run-hook 'ess:format-window-1)
