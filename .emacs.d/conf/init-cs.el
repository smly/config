; C# style
(add-to-list 'load-path "~/.emacs.d/elisp/csharp-mode")
(require 'csharp-mode)
(require 'flymake-for-csharp)

(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist (cons '("\\.cs$" . csharp-mode) auto-mode-alist))

(add-hook 'csharp-mode-hook (lambda ()
                              (setq c-basic-offset 2
                                    tab-width 2
                                    indent-tabs-mode nil)))
(autoload 'csharp-mode "csharp-mode" "C# editing mode." t)

;
(setq-default compile-command "mcs ")

; compile
(lazyload (smart-compile) "smart-compile"
          append-to-list smart-compile-alist
          '(("\\.cs\\'", "mcs %f")))

(defun smly-csharp-mode-fn ()
  (cond (window-system
         (c-set-style "myC#Style")
         (setq skeleton-pair t)
         (flymake-mode)
         )))

; flymake
(add-hook 'csharp-mode-hook
          'smly-csharp-mode-fn)