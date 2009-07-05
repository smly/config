;; for gitit
;; git clone git://github.com/tsgates/git-emacs.git
(add-to-list 'load-path "~/.emacs.d/elisp/git-emacs")
;(add-to-load-path "~/.emacs.d/elisp/git-emacs")
(require 'git-emacs)

;; markdown format
;; git clone git://code.jblevins.org/markdown-mode.git
(add-to-list 'load-path "~/.emacs.d/elisp/markdown-mode")
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.page" . markdown-mode) auto-mode-alist))