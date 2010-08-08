; swi-prolog
(setq auto-mode-alist
      (append '(("\\.prl" . prolog-mode))
       auto-mode-alist))
(setq prolog-program-name "/usr/bin/swipl")
(setq prolog-consult-string "[user].\n")
