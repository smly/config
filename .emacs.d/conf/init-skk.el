;; Add pahts to SKK and APEL
; ref: http://d.hatena.ne.jp/tomoya/20080903/1220406574 [+]

(defvar system-load-path load-path)
(setq my-load-path '("/usr/share/emacs/23.0.90/site-lisp/skk"
                     "/usr/share/emacs/site-lisp/apel"
                     "/usr/share/emacs/23.0.90/site-lisp/emu"))
(setq load-path (append my-load-path system-load-path))

;; Configure for SKK
(require 'skk-autoloads)
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)
;; Specify dictionary location
(setq skk-large-jisyo "/usr/local/share/skk/SKK-JISYO.L")
;; Specify tutorial location
(setq skk-tut-file "/usr/share/skk/SKK.tut")

(add-hook 'isearch-mode-hook
          (function (lambda ()
                      (and (boundp 'skk-mode) skk-mode
                           (skk-isearch-mode-setup)))))

(add-hook 'isearch-mode-end-hook
          (function
           (lambda ()
             (and (boundp 'skk-mode) skk-mode (skk-isearch-mode-cleanup))
             (and (boundp 'skk-mode-invoked) skk-mode-invoked
                  (skk-set-cursor-properly)))))
