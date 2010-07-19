(setq load-path (cons "/usr/share/emacs/site-lisp/ess" load-path))
(load "/usr/share/emacs/site-lisp/ess/ess-site")

(setq ess-ask-for-ess-directory nil)
(setq ess-local-process-name "R")
(setq ansi-color-for-comint-mode 'filter)
(setq comint-prompt-read-only t)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)

(defun my-ess-start-R ()
  (interactive)
  (if (not (member "*R*" (mapcar (function buffer-name) (buffer-list))))
      (progn
        (delete-other-windows)
        (setq w1 (selected-window))
        (setq w1name (buffer-name))
        (setq w2 (split-window w1))
        (R)
        (set-window-buffer w2 "*R*")
        (set-window-buffer w1 w1name))))

(defun my-ess-eval ()
  (interactive)
  (my-ess-start-R)
  (if (and transient-mark-mode mark-active)
      (call-interactively 'ess-eval-region)
    (call-interactively 'ess-eval-line-and-step)))

(add-hook 'ess-mode-hook
          '(lambda()
             (local-set-key [(shift return)] 'my-ess-eval)))

(add-hook 'inferior-ess-mode-hook
          '(lambda()
             (local-set-key [C-up] 'comint-previous-input)
             (local-set-key [C-down] 'comint-next-input)))

(require 'ess-site)

(setq ess-ask-for-ess-directory nil)
(setq ess-pre-run-hook
      '((lambda ()
          (setq default-process-coding-system 'utf-8-unix)
;          (setq default-process-coding-system '(utf8 . utf8))
          )))

;; (defun ess:format-window-1 ()
;;   (split-window-horizontally)
;;   (other-window 1)
;;   (split-window)
;;   (other-window 1))
;; (add-hook 'ess-pre-run-hook 'ess:format-window-1)
