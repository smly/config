(add-to-load-path "~/.emacs.d/elisp/yatex")
(require 'yatex)
; http://www.yatex.org/
(add-to-list 'auto-mode-alist '("\\.tex$" . yatex-mode))
(setq tex-command "/usr/local/teTeX/bin/platex")
(setq dvi2-command "/usr/local/teTeX/bin/xdvi-motif -s 4 -display :0")
