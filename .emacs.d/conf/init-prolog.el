; swi-prolog
(setq auto-mode-alist
      (append '(("\\.pl" . prolog-mode))
       auto-mode-alist))
(setq prolog-program-name "/usr/bin/pl")
(setq prolog-consult-string "[user].\n")
